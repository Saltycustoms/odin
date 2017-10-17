class Gateway::PaypalSdk < Gateway
  jsonb_accessor :properties,
                  account: [:string, default: nil],
                  client_id: [:string, default: nil],
                  client_secret: [:string, default: nil],
                  staging: [:boolean, default: false]

  def return_url
  end

  def form_partial
    'gateway/paypal'
  end

  def minimum_amount
    0
  end

  def gateway_timeout
    600
  end

  def self.settings_fields
    [:account,:client_id,:client_secret]
  end

  def is_integration
    true
  end

  def use_form_proxy
    false
  end

  def form_destination(transaction, transaction_type='SALE', options={})
    Paypal.sandbox! if Rails.env.development?
    items = []
    order = transaction.order
    order.lines.each do |line|
      items << {quantity: line.quantity, name: line.display_name, amount: line.amount}
    end

    if order.coupon
      items << {quantity: 1, name: "Coupon Discount", amount: order.coupon_adjustment}
    end

    paypal_options = {
      allow_note: false, # if you want to disable notes
      pay_on_paypal: true # if you don't plan on showing your own confirmation step
    }

    request = Paypal::Express::Request.new(
      :username   => self.account,
      :password   => self.client_id,
      :signature  => self.client_secret
    )

    payment_hash = {
      :currency_code => :USD,   # if nil, PayPal use USD as default
      :amount        => order.amount.to_s,   # item value
      :description => "Order #{order.id}",
      :items => items,
      :email => order.email,
      :invoice_number => "SP#{order.id}",
      :custom_fields => {
        PAYMENTREQUEST_0_PAYMENTACTION: "Sale",
        PAYMENTREQUEST_0_NOTIFYURL: 'https://payments.saltycustoms.com/api/paypal_ipn'
      }
    }



    payment_request = Paypal::Payment::Request.new(payment_hash)
    begin
      response = request.setup(
        payment_request,
        options[:return_url] + '?gateway_id=' + self.id.to_s,
        options[:cancel_url],
        paypal_options  # Optional
      )

      return response.redirect_uri
    rescue Exception  => e
      raise [request,e.response,payment_hash].inspect
    end
  end

  def form_attributes(transaction, transaction_type='AUTH', options={})
  end

  def validate_params(transaction,params)
  end

  def is_return_data?(params)
    !params[:token].nil? && !params[:PayerID].nil? && params[:gateway_id] == self.id.to_s
  end

  def update_transaction(params)
      order = Order.find_by_uuid params[:order_id]
      transaction = order.transactions.find_by ref: params[:token]
      if transaction&.succeeded?
        return transaction
      end
      transaction = order.transactions.pending.last if !transaction

      request = Paypal::Express::Request.new(
        :username   => self.account,
        :password   => self.client_id,
        :signature  => self.client_secret
      )

      items = []
      order.lines.each do |line|
        items << {quantity: line.quantity, name: line.display_name, amount: line.amount}
      end

      payment_hash = {
        :currency_code => :USD,   # if nil, PayPal use USD as default
        :amount        => order.amount.to_s,   # item value
        :description => "Order #{order.id}",
        :items => items,
        :email => order.email,
        :invoice_number => "SP#{order.id}",
        :custom_fields => {
          PAYMENTREQUEST_0_PAYMENTACTION: "Sale",
          PAYMENTREQUEST_0_NOTIFYURL: 'https://payments.saltycustoms.com/api/paypal_ipn'
        }
      }

      details_res = request.checkout!(params[:token],params[:PayerID],Paypal::Payment::Request.new(payment_hash))

      case details_res.ack
        when 'Success' #success
          transaction.status = "succeeded"
        else # failed
          transaction.status = "failed"
      end
      transaction.amount_cents = params[:Amount].to_i * 100
      transaction.ref = params[:token]
      transaction.raw_data = details_res.to_json
      if transaction.save
        transaction.order.pay! if transaction.succeeded?
      end
      return transaction

  end

  def purchase(transaction, amount_cents=nil, options={})

  end

  def credit(transaction, amount_cents=nil, options={})

  end

  def void(transaction, amount_cents=nil, options={})

  end

end
