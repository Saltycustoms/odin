# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".country-select").change ->
    $.ajax
      url: '/states?country='+ $(this).val()
      dataType: "html",
      type: 'get',
      success: (data, status, jqXHR) ->
        state_html = data
        $('.state-select').html(state_html)

  $("#packing_list_upload_attachment").change ->
    checked = $(this).is(":checked")
    if checked
      $(".packing-list-manual").hide()
      $(".packing-list-upload").show()
    else
      $(".packing-list-manual").show()
      $(".packing-list-upload").hide()

  $("#auto-fill-address").click ->
    address = $("#organization-address").data("organization-address")
    if address != null
      $.ajax
        url: '/states?country='+ address.country_code
        dataType: "html",
        type: 'get',
        success: (data, status, jqXHR) ->
          state_html = data
          $('.state-select').html(state_html)
          $("#packing_list_address_attributes_name").val(address.name)
          $("#packing_list_address_attributes_address1").val(address.address1)
          $("#packing_list_address_attributes_address2").val(address.address2)
          $("#packing_list_address_attributes_city").val(address.city)
          $("#packing_list_address_attributes_postal_code").val(address.postal_code)
          $("#packing_list_address_attributes_country_code").val(address.country_code)
          $("#packing_list_address_attributes_state").val(address.state)
