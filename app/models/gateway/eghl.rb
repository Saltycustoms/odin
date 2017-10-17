class Gateway::Eghl < Gateway
  jsonb_accessor :properties,
                  service_id: [:string, default: nil],
                  merchant_name: [:string, default: nil],
                  merchant_password: [:string, default: nil],
                  payment_prefix: [:string, default: 'TXX']

  def return_url
  end

  def form_partial
    'gateway/eghl'
  end

  def minimum_amount
    0
  end

  def gateway_timeout
    600
  end

  def self.settings_fields
    [:service_id,:merchant_name,:merchant_password,:payment_prefix]
  end

  def is_integration
    false
  end

  def use_form_proxy
    true
  end

  def form_destination
    if Rails.env.production?
      return 'https://securepay.e-ghl.com/IPG/Payment.aspx'
    else
      return 'https://test2pay.ghl.com/IPGSG/Payment.aspx'
    end
  end

  def form_attributes(transaction, transaction_type='AUTH', options={})
    order = transaction.order
    h = {
      ServiceID:             self.service_id.to_s,
      PaymentID:             "#{payment_prefix}#{transaction.id}",
      MerchantReturnURL:     options[:return_url],#url_for(action: :return),
      MerchantApprovalURL:   options[:approve_url],#url_for(action: :approval),
      MerchantUnApprovalURL: options[:cancel_url],#url_for(action: :unapproval),
      MerchantCallBackURL:   options[:callback_url],#url_for(action: :callback),
      Amount:                transaction.amount.to_s,
      CurrencyCode:          'MYR',
      CustIP:                options[:ip] || '',
      PageTimeout:           gateway_timeout.to_s,
      OrderNumber:           transaction.order.id,
      TransactionType:       transaction_type,
      PymtMethod:            'CC',
      PaymentDesc:           "Payment for order #{transaction.order.id}",
      MerchantName:          self.merchant_name,
      CustName:              order.billing_address&.att || order.shipping_address&.att,
      CustEmail:             order.user.email,
      CustPhone:             order.billing_address&.tel,
      LanguageCode:          'en',
      B4TaxAmt:               order.net_total,
      TaxAmt:                 order.grand_total,
      Param6:                 self.id
    }

    h[:HashValue] = calculate_payment_request_hash h
    h
  end

  def validate_params(transaction,params)
      transaction.error_message = params[:TxnMessage]
      return (Time.now - transaction.created_at < gateway_timeout) &&
               (params[:HashValue2] == self.calculate_response_hash(params)) &&
               (params[:TxnStatus] != '1')
  end

  def is_return_data?(params)
    !params[:TxnStatus].nil? && !params[:HashValue2].nil? && params[:Param6] == self.id.to_s
  end

  def update_transaction(params)
    if (params[:HashValue2] == self.calculate_response_hash(params))
      transaction_id = params[:PaymentID].gsub(payment_prefix|| '','')
      transaction = Transaction.where(id: transaction_id).first
      return false if transaction.nil?
      case params[:TxnStatus]
      when '0' #success
          transaction.status = "succeeded"
        when '1' # cancelled
          transaction.status = "cancelled"
        when '2' # failed
          transaction.status = "failed"
      end
      transaction.amount_cents = params[:Amount].to_i * 100
      transaction.ref = params[:TxnID]
      transaction.raw_data = params.to_json
      if transaction.save
        transaction.order.pay! if transaction.succeeded?
      end
      return transaction
    end
    false
  end

  def purchase(transaction, amount_cents=nil, options={})

  end

  def credit(transaction, amount_cents=nil, options={})

  end

  def void(transaction, amount_cents=nil, options={})

  end

  def calculate_payment_request_hash params
    s = self.merchant_password +
      ( params[:ServiceID]||'' )             +
      ( params[:PaymentID]||'' )             +
      ( params[:MerchantReturnURL]||'' )     +
      ( params[:MerchantApprovalURL]||'' )   +
      ( params[:MerchantUnApprovalURL]||'' ) +
      ( params[:MerchantCallBackURL]||'' )   +
      ( params[:Amount]||'' )                +
      ( params[:CurrencyCode]||'' )          +
      ( params[:CustIP]||'' )                +
      ( params[:PageTimeout]||'' )           +
      ( params[:CardNo]||'' )                +
      ( params[:Token]||'' )

    return Digest::SHA256.hexdigest s
  end

  def calculate_response_hash params
    s = self.merchant_password +
      ( params[:TxnID]||'' ) +
      ( params[:ServiceID]||'' ) +
      ( params[:PaymentID]||'' ) +
      ( params[:TxnStatus]||'' ) +
      ( params[:Amount]||'' ) +
      ( params[:CurrencyCode]||'' ) +
      ( params[:AuthCode]||'' ) +
      ( params[:OrderNumber]||'' ) +
      ( params[:Param6]||'' ) +
      ( params[:Param7]||'' )

    return Digest::SHA256.hexdigest s
  end
end
