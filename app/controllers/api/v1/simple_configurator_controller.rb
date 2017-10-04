class SimpleConfiguratorController < ApiController
  def create
    # name blank first, don't lookup for existing organization with submited company name
    # because user can type any name they one, so now let AC key in first
    description = ""
    description = description.concat "First name: " + params[:contact_detail][:first_name]
    description = description.concat "Last name: " + params[:contact_detail][:last_name]
    description = description.concat "Company name: " + params[:contact_detail][:company_name]
    description = description.concat "Email: " + params[:contact_detail][:email]
    description = description.concat "Phone: " + params[:contact_detail][:phone_no]
    description = description.concat "Billing Address: " + params[:contact_detail][:billing_address][:address1]
                                      + params[:contact_detail][:billing_address][:address2]
                                      + params[:contact_detail][:billing_address][:country_code]
                                      + params[:contact_detail][:billing_address][:state]
                                      + params[:contact_detail][:billing_address][:postal_code]
                                      + params[:contact_detail][:billing_address][:city]
    description = description.concat "Shipping Address: " + params[:contact_detail][:shipping_address][:address1]
                                      + params[:contact_detail][:shipping_address][:address2]
                                      + params[:contact_detail][:shipping_address][:country_code]
                                      + params[:contact_detail][:shipping_address][:state]
                                      + params[:contact_detail][:shipping_address][:postal_code]
                                      + params[:contact_detail][:shipping_address][:city]
    # set with total of all quantity
    no_of_pcs = 0
    product_id = params[:product_id]
    # because simple configurator can have only 1 fabric color
    color_ids = [] << params[:color_id]
    size_ids = params[:size_ids]
    attachment = params[:artwork]
    #like old simple configurator, Front A4, Front 3x3,
    block = params[:print_block]
    position = params[:print_position]
    color_count = params[:color_count]
    print_method = "Silkscreen"
    @organization = Organization.new(name: "", description: description)
    @deal = @organization.deals.new(name: "Simple Configurator Deal", no_of_pcs: no_of_pcs, )
    @pic = Pic.new(name: "#{params[:contact_detail][:first_name]} #{params[:contact_detail][:last_name]}",
           tel: "#{params[:contact_detail][:phone_no]}", email: "#{params[:contact_detail][:email]}",
           belongable: @deal)
    #create preview design on deal
    @job_request = @deal.job_requests.new(product_id: product_id, name: "Template Job Request",
                                          sizes: size_ids, colors: color_ids, provide_artwork: true)
    @attachment = @job_request.attachments.new(attachment: attachment)
    @job_request.print_details.new(position: position, block: block, color_count: color_count, print_method: print_method)

    #calculate price
    #check coupon, coupon valid, return coupon discount_id
    @discount = nil
    @quotation = @deal.quotation.new(discount_id: @discount&.id)
    @quotation.quotation_lines.new()
  end
  
  def product
    @product = Product.where(simple_configurator: true, active: true).first
  end
end
