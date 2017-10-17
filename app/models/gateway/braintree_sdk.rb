require "braintree"
class Gateway::BraintreeSDK < Gateway
  jsonb_accessor :properties,
                  merchant_id: [:string, default: nil],
                  public_key: [:string, default: nil],
                  private_key: [:string, default: nil],
                  merchant_account_id: [:string, default: nil],
                  currency: [:string, default: nil],
                  payment_prefix: [:string, default: 'TXX'],
                  staging: [:boolean, default: false]

  def self.settings_fields
    [:merchant_id,:merchant_account_id,:currency,:public_key,:private_key,:payment_prefix,:staging]
  end

  def generate_token
    Braintree::Configuration.environment =  self.staging? ? :sandbox  : :production
    Braintree::Configuration.merchant_id = self.merchant_id
    Braintree::Configuration.public_key = self.public_key
    Braintree::Configuration.private_key = self.private_key
    Braintree::ClientToken.generate
  end

  def return_url
  end

  def form_partial
    'gateway/braintree'
  end

  def minimum_amount
    0
  end

  def gateway_timeout
    600
  end

  def is_integration
    false
  end

  def use_form_proxy
    true
  end

  def form_destination(transaction, transaction_type='SALE', options={})

  end

  def form_attributes(transaction, transaction_type='AUTH', options={})

  end

  def validate_params(transaction,params)
      true
  end

  def is_return_data?(params)
    !params[:payment_method_nonce].nil? && params[:gwid] == self.id.to_s
  end

  def update_transaction(params)
    deal = Deal.find_by_uuid(params[:order_id])
    transaction = deal.transactions.pending.last
    transaction = deal.transactions.find_by_id(params[:transaction_id]) if params[:transaction_id]

    shipping_address = deal.packing_lists.first.address.to_transactional
    shipping_address[:first_name] = deal.pic.name
    billing_address = deal.pic.billing_address.to_transactional
    billing_address[:first_name] = deal.pic.name

    amount_to_be_pay = deal.remaining_amount

    # return deal.transactions.succeeded.last if
    return false if transaction.nil?
    Braintree::Configuration.environment =  self.staging? ? :sandbox  : :production
    Braintree::Configuration.merchant_id = self.merchant_id
    Braintree::Configuration.public_key = self.public_key
    Braintree::Configuration.private_key = self.private_key
    result = Braintree::Transaction.sale(
      customer: {
        email: deal.pic.email,
        phone: deal.pic.tel,
      },
      shipping: shipping_address,
      billing: billing_address,
      merchant_account_id: self.merchant_account_id,
      :amount => deal.remaining_amount,
      order_id: "#{self.payment_prefix}-#{deal.id}",
      :payment_method_nonce => params[:payment_method_nonce],
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success?
        transaction.status = "succeeded"
    else
        transaction.status = "failed"
    end
    transaction.amount = amount_to_be_pay
    transaction.ref = result.transaction.id
    transaction.raw = result.inspect
    transaction.save
    return transaction
  end

  # def update_transaction(params)
  #     order = Order.find_by_uuid(params[:order_id])
  #     transaction = order.transactions.pending.last
  #     transaction = order.transactions.find_by_id(params[:transaction_id]) if params[:transaction_id]
  #
  #     return order.transactions.succeeded.last if order.paid?
  #
  #     return false if transaction.nil?
  #     Braintree::Configuration.environment =  self.staging? ? :sandbox  : :production
  #     Braintree::Configuration.merchant_id = self.merchant_id
  #     Braintree::Configuration.public_key = self.public_key
  #     Braintree::Configuration.private_key = self.private_key
  #     result = Braintree::Transaction.sale(
  #       customer: {
  #         email: order.email,
  #         phone: order.shipping_address.tel,
  #       },
  #       shipping: order&.shipping_address&.to_transactional,
  #       billing: order&.billing_address&.to_transactional,
  #       merchant_account_id: self.merchant_account_id,
  #       :amount => order.amount,
  #       order_id: "#{self.payment_prefix}-#{order.id}",
  #       :payment_method_nonce => params[:payment_method_nonce],
  #       :options => {
  #         :submit_for_settlement => true
  #       }
  #     )
  #     if result.success?
  #         transaction.status = "succeeded"
  #     else
  #         transaction.status = "failed"
  #     end
  #     transaction.amount_cents = order.amount_cents
  #     transaction.ref = result.transaction.id
  #     transaction.raw_data = result.inspect
  #     if transaction.save
  #       transaction.order.pay! if transaction.succeeded?
  #     end
  #     return transaction
  # end

  def purchase(transaction, amount_cents=nil, options={})

  end

  def credit(transaction, amount_cents=nil, options={})

  end

  def void(transaction, amount_cents=nil, options={})

  end

end
