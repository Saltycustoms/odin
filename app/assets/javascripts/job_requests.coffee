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

  $("#add-pantone-button").click ->
    current_time = Date.now()
    pantone_form = "<div class='row align-bottom'>"
    pantone_form +=   "<div class='column'>"
    pantone_form +=     "<label for='pantone_colors_" + current_time + "_name'>Name</label>"
    pantone_form +=     "<input type='text' name='pantone_colors[" + current_time + "][name]' id='pantone_colors_" + current_time + "_name'>"
    pantone_form +=   "</div>"
    pantone_form +=   "<div class='column'>"
    pantone_form +=     "<label for='pantone_colors_" + current_time + "_hex'>Hex</label>"
    pantone_form +=     "<input type='text' name='pantone_colors[" + current_time + "][hex]' id='pantone_colors_" + current_time + "_hex'>"
    pantone_form +=   "</div>"
    pantone_form +=   "<div class='column'>"
    pantone_form +=     "<label for='pantone_colors_" + current_time + "_pantone_code'>Pantone Code</label>"
    pantone_form +=     "<input type='text' name='pantone_colors[" + current_time + "][pantone_code]' id='pantone_colors_" + current_time + "_pantone_code'>"
    pantone_form +=   "</div>"
    pantone_form +=   "<div class='small-1 column'>"
    pantone_form +=     "<a class='button alert remove-pantone-color' href='javascript:void(0)' onclick='removePantoneForm(this)'>"
    pantone_form +=       "<i class='fa fa-times' aria-hidden='true'></i>"
    pantone_form +=     "</a>"
    pantone_form +=   "</div>"
    pantone_form += "</div>"
    $("#pantone-colors-form").append(pantone_form)
    
  @removePantoneForm = (element) ->
    $(element).parent().parent().remove()
