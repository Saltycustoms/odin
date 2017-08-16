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
