# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $("#product-select").change ->
    product_id = $(this).val()
    if product_id != ""
      $.ajax
        url: '/products/' + product_id
        type: 'get'
        success: (data, status, XHR) ->
          sizes_html = ""
          for size in data.sizes
            sizes_html += "<option value='" + size.id + "'>" + size.name + "</option>"
          $("#sizes-select").html(sizes_html)

          colors_html = ""
          for color in data.colors
            colors_html += "<option value='" + color.id + "'>" + color.name + "</option>"
          $("#colors-select").html(colors_html)
