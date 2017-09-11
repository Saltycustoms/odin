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

  $("#packing_list_shipping_method").change ->
    if $(this).val() == "self_pick_up"
      $(".self-pickup-locations-container").show()
    else
      $(".self-pickup-locations-container").hide()

  $(".self-pickup-locations-container input[type='radio']").change ->
    self_pick_up_location = $(this).val()
    switch self_pick_up_location
      when "malaysia"
        $.ajax
          url: '/states?country=MY'
          dataType: "html",
          type: 'get',
          success: (data, status, jqXHR) ->
            state_html = data
            $('.state-select').html(state_html)
            $("#packing_list_address_attributes_name").val("Saltyskins Sdn Bhd")
            $("#packing_list_address_attributes_address1").val("A513 & 515 Kelana Square")
            $("#packing_list_address_attributes_address2").val("Jalan SS7/26, Kelana Jaya")
            $("#packing_list_address_attributes_city").val("Petaling Jaya")
            $("#packing_list_address_attributes_postal_code").val("47301")
            $("#packing_list_address_attributes_country_code").val("MY")
            $("#packing_list_address_attributes_state").val("Selangor")
      when "singapore"
        $.ajax
          url: '/states?country=SG'
          dataType: "html",
          type: 'get',
          success: (data, status, jqXHR) ->
            state_html = data
            $('.state-select').html(state_html)
            $("#packing_list_address_attributes_name").val("Saltycustoms Pte Ltd")
            $("#packing_list_address_attributes_address1").val("71 Ubi Road 1")
            $("#packing_list_address_attributes_address2").val("#06-42 Oxley BizHub 1")
            $("#packing_list_address_attributes_city").val("Ubi")
            $("#packing_list_address_attributes_postal_code").val("408732")
            $("#packing_list_address_attributes_country_code").val("SG")
            $("#packing_list_address_attributes_state").val("South West")
