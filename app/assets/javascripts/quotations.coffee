# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".quantity-input").change ->
    product_id = $(this).data("product-id")
    job_request_id = $(this).data("job-request-id")
    job_request_values = $(".quantity-input[data-job-request-id='" + job_request_id + "']")
    product_count = 0
    for value in job_request_values
      product_count += parseInt($(value).val())

    $(".quantity-input")
    $.ajax
      url: '/products/' + product_id + '/price_ranges'
      type: 'get'
      data: {product_count: product_count}
      success: (data, status, XHR) ->
        $("span[data-job-request-id='" + job_request_id + "']").html(data.configurator_price)
