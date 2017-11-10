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
          if data.custom_dye
            deal_id = $("#add-pantone-color-link").data("deal-id")
            $("#add-pantone-color-link").show()
            $("#add-pantone-color-link").attr("href", "/products/" + product_id + "/colors/new?deal_id=" + deal_id)
          else
            $("#add-pantone-color-link").hide()
            $("#add-pantone-color-link").attr("href", "javascript:void(0)")

          sizes_html = ""
          for size in data.sizes
            sizes_html += "<option value='" + size.id + "'>" + size.name + "</option>"
          $("#sizes-select").html(sizes_html)

          colors_html = ""
          for color in data.colors
            if color.pantone_code
              display_name = "#{color.name} (#{color.pantone_code})"
            else
              display_name = color.name
            colors_html += "<option value='" + color.id + "'>" + display_name + "</option>"
          $("#colors-select").html(colors_html)
    else
      $("#sizes-select").html("")
      $("#colors-select").html("")