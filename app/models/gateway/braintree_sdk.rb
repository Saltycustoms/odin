class Gateway::BraintreeSDK < Gateway
  jsonb_accessor :properties,
                  merchant_id: [:string, default: nil],
                  public_key: [:string, default: nil],
                  private_key: [:string, default: nil],
                  merchant_account_id: [:string, default: nil]

  after_find :set_environment

  def set_environment
    if self.properties.present?
      Braintree::Configuration.environment = :sandbox
      Braintree::Configuration.merchant_id = self.properties["merchant_id"]
      Braintree::Configuration.public_key  = self.properties["public_key"]
      Braintree::Configuration.private_key = self.properties["private_key"]
    end
  end

  def generate_token
    Braintree::ClientToken.generate
  end

  def braintree_transaction(order, nonce)
    result = Braintree::Transaction.sale(
      customer: {
        email: order.email,
        phone: order.shipping_address.tel,
      },
      amount: order.grand_total,
      merchant_account_id: self.merchant_account_id,
      payment_method_nonce: nonce,
      purchase_order_number: "MISE#{order.id}",
      shipping: transaction_shipping_address(order.shipping_address),
      billing: transaction_billing_address(order.billing_address),
      :options => {
        :submit_for_settlement => true
      }
    )
    return result
  end

  def transaction_billing_address(billing_address)
    {
      country_code_alpha2: billing_address.country_code,
      postal_code: billing_address.post_code,
      street_address: billing_address.line1,
      extended_address: billing_address.line2,
      region: billing_address.state,
      locality: billing_address.city,
      first_name: billing_address.att,
      company: billing_address.tel
    }
  end

  def transaction_shipping_address(shipping_address)
    {
      country_code_alpha2: shipping_address.country_code,
      postal_code: shipping_address.post_code,
      street_address: shipping_address.line1,
      extended_address: shipping_address.line2,
      region: shipping_address.state,
      locality: shipping_address.city,
      first_name: shipping_address.att,
      company: shipping_address.tel
    }
  end

  def create_transaction(order, nonce, result, status)
    order.transactions.create(
      type: Transaction::Purchase,
      raw_data: result.inspect,
      ref: result.transaction.id,
      token: nonce,
      status: status,
      amount_cents: order.grand_total_cents,
      gateway: self
    )
  end
end
