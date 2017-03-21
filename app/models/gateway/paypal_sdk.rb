class Gateway::PaypalSDK < Gateway
  include PayPal::SDK::REST
  jsonb_accessor :properties,
                  client_id: [:string, default: nil],
                  secret_key: [:string, default: nil]

  CURRENCY = "USD"
  def form_partial
    'gateway/paypal'
  end

  def form_destination

  end

  def is_return_data?(params)
    params[:paymentId].presence &&
    params[:PayerID].presence &&
    params[:token].presence
  end

  def update_transaction(params)
    if params[:payment_cancelled].presence
      transaction = ::Transaction.find(params[:transaction_id])
      transaction.status = "cancelled"
      transaction.save
    else
      payment_id = params[:paymentId]
      payer_id = params[:PayerID]
      payment = Payment.find(payment_id)
      custom_params = self.parse_params(payment.transactions.first.custom)
      order = ::Order.find(custom_params[:order_id])
      transaction = ::Transaction.find(custom_params[:transaction_id])
      return false if transaction.nil?
      # Execute payment using payer_id obtained from query string following redirect
      if payment.execute( :payer_id => payer_id )
        # logger.info "authorization executed successfully"
        # Capture auth id
        auth_id = payment.transactions[0].related_resources[0].authorization.id;
        transaction.token = auth_id
        transaction.raw_data = payment.to_json
        transaction.status = "succeeded"
      else
        # logger.error payment.error.inspect
        raw_data = {}
        raw_data[:payment] = payment.to_json
        raw_data[:error] = payment.error.to_json
        transaction.raw_data = raw_data
        transaction.status = "failed"
      end
      if transaction.save
        order = transaction.order
        total_captured = order.captured_transactions.succeeded.sum(:amount_cents)
        total_purchased = order.purchased_transactions.succeeded.sum(:amount_cents)
        transaction.order.pay! if (total_captured + total_purchased) >= order.grand_total_cents
        if transaction.order_lines.presence
          #not using where and update all to prevent not log
          order_line_ids = transaction.order_lines.split(",").each do |id|
            begin
              order_line = OrderLine.find(id)
              order_line.paid!
            rescue RecordNotFound => e
              logger.error e.inspect
            end
          end
        end
      end
    end
    transaction
  end

  def parse_params(params)
    hash = {}
    params.split("&").each do |param|
      param_a = param.split("=")
      hash[param_a.first.to_sym] = param_a.second
    end
    return hash
  end

  def generate_authorization_link(transaction, method, return_url, cancel_url)
    items = []
    currency = CURRENCY
    transaction.order.lines.each do |i|
      items.push({
        name: "#{i.display_name}",
        price: i.price_per_unit,
        currency: currency,
        quantity: i.quantity
      })
    end
    transaction.order.shipments.each do |s|
      items.push({
        name: "Shipping for campaign #{s.campaign.name}",
        price: s.amount,
        currency: currency,
        quantity: 1
      })
    end
    PayPal::SDK::REST.set_config({
      mode: "sandbox",
      :client_id     => self.client_id,
      :client_secret => self.secret_key
    })
    shipping_address = transaction.order.shipping_address
    billing_address  = transaction.order.billing_address
    payment = Payment.new({
    :intent =>  "authorize",

      # Set payment type
      :payer =>  {
        :payment_method =>  method,
        payer_info: {
          billing_address: {
            line1: billing_address.line1,
            line2: billing_address.line2,
            city: billing_address.city,
            country_code: billing_address.country_code,
            postal_code: billing_address.post_code,
            phone: billing_address.tel,
            state: billing_address.state
          }
        }
      },

      # Set redirect urls
      # :redirect_urls => {
      #   :return_url => "http://localhost/payment/execute",
      #   :cancel_url => "http://localhost:3000/"
      # },
      :redirect_urls => {
        :return_url => return_url,
        :cancel_url => return_url + "?payment_cancelled=true&paymentId=cancelled&PayerID=cancelled&token=cancelled&transaction_id=#{transaction.id}"
      },

      # Set transaction object
      :transactions =>  [{
        custom: "order_id=#{transaction.order.id}&transaction_id=#{transaction.id}",
        details: {
          subtotal: transaction.order.subtotal,
          shipping: transaction.order.shipment_total
        },
        :item_list => {
          items: items
        },

        # Amount - must match item list breakdown price
        :amount =>  {
          :total => transaction.amount,
          :currency =>  currency
        },
        shipping_address: {
          recipient_name: shipping_address.att,
          line_1: shipping_address.line1,
          line_2: shipping_address.line2,
          city: shipping_address.city,
          country_code: shipping_address.country_code,
          postal_code: shipping_address.post_code,
          phone: shipping_address.tel,
          state: shipping_address.state
        },
        :description =>  "payment description."
      }]
    })

    # Create payment
    if payment.create
      # Capture redirect url
      redirect_url = payment.links.find{|v| v.rel == "approval_url" }.href

      # REDIRECT USER TO redirect_url
    else
      logger.error payment.error.inspect
      raw_data = {}
      raw_data[:payment] = payment.to_json
      raw_data[:error] = payment.error.to_json
      transaction.raw_data = raw_data
      transaction.status = "failed"
      transaction.save
      false
    end
  end

  def get_authorization_token(payment_id, payer_id)
    # Get payment id from query string following redirect
    payment = Payment.find(payment_id)

    # Execute payment using payer_id obtained from query string following redirect
    if payment.execute( :payer_id => payer_id )
      logger.info "authorization executed successfully"

      # Capture auth id
      auth_id = payment.transactions[0].related_resources[0].authorization.id;
    else
      logger.error payment.error.inspect
    end
  end

  def get_payment_object(payment_id)
    Payment.find(payment_id)
  end

  def capture(auth_id, transaction, final_payment = false)
    authorization = Authorization.find(auth_id)
    capture = authorization.capture({
      :amount => {
        :currency => CURRENCY,
        :total => transaction.amount
      },
      :is_final_capture => final_payment
    })

    if capture.success?
      logger.info "Capture[#{capture.id}]"
      transaction.raw_data = capture.to_json
      transaction.status = "succeeded"
    else
      logger.error capture.error.inspect
      transaction.raw_data = capture.error.to_json
      transaction.status = "failed"
    end
    transaction.save
  end

  def payment_link(transaction, return_url, cancel_url, item_options)
    PayPal::SDK::REST.set_config({
      mode: "sandbox",
      :client_id     => self.client_id,
      :client_secret => self.secret_key
    })

    @payment = Payment.new({
      :intent => "sale",
      :payer => {
        payment_method: "paypal"
      },
      :redirect_urls => {
        :return_url => return_url,
        :cancel_url => cancel_url
      },
      :transactions => [{
        custom: "order_id=#{transaction.order.id}&transaction_id=#{transaction.id}",
        :item_list => {
          :items => item_options},
        :amount => {
          :total => transaction.amount,
          :currency => CURRENCY },
        :description => "This is the payment transaction description."
      }]
    })

    if @payment.create
      redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
    else
      @payment.error  # Error Hash
    end
  end

  def create_payout(payout, items)
    PayPal::SDK::REST.set_config({
      mode: "sandbox",
      :client_id     => self.client_id,
      :client_secret => self.secret_key
    })

    @payout = Payout.new({
                         :sender_batch_header => {
                             :sender_batch_id => SecureRandom.hex(8),
                             :email_subject => 'You have a Payout!'
                         },
                         :items => items
                     })
    begin
      @payout_batch = @payout.create
      payout.batch_id = @payout_batch.batch_header.payout_batch_id
      payout.raw_data = @payout_batch.to_json
      payout.status = "collecting"
      payout.save
      # logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
    rescue => err
      # logger.error @payout.error.inspect
      if @payout&.error
        payout.raw_data = @payout.error.inspect
      else
        payout.raw_data = {system_error: err}.to_json
      end
      payout.amount_cents = 0
      payout.status = "failed"
      payout.save
    end
    payout
  end

  def get_payout(batch_id)
    PayPal::SDK::REST.set_config({
      mode: "sandbox",
      :client_id     => self.client_id,
      :client_secret => self.secret_key
    })
    @payout = Payout.get(batch_id)
  end
end
