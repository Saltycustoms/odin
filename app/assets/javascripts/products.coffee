$(document).on "turbolinks:load", ->
  $("#add-pantone-button").click ->
     current_time = Date.now()
     pantone_form = "<div class='row'>"
     pantone_form +=   "<div class='column'>"
     pantone_form +=     "<label for='pantone_colors_" + current_time + "_name'>Name</label>"
     pantone_form +=     "<input type='text' name='pantone_colors[" + current_time + "][name]' id='pantone_colors_" + current_time + "_name'>"
     pantone_form +=   "</div>"
     pantone_form +=   "<div class='column'>"
     pantone_form +=     "<label for='pantone_colors_" + current_time + "_hex'>Hex</label>"
     pantone_form +=     "<input type='text' name='pantone_colors[" + current_time + "][hex]' id='pantone_colors_" + current_time + "_hex'>"
     pantone_form +=   "</div>"
     pantone_form +=   "<div class='column'>"
     pantone_form +=     "<label for='pantone_colors_" + current_time + "_pantone_code'><abbr title='required'>*</abbr> Pantone Code</label>"
     pantone_form +=     "<input type='text' name='pantone_colors[" + current_time + "][pantone_code]' id='pantone_colors_" + current_time + "_pantone_code'>"
     pantone_form +=   "</div>"
     pantone_form +=   "<div class='small-1 column align-self-bottom'>"
     pantone_form +=     "<a class='button alert remove-pantone-color' href='javascript:void(0)' onclick='removePantoneForm(this)'>"
     pantone_form +=       "<i class='fa fa-times' aria-hidden='true'></i>"
     pantone_form +=     "</a>"
     pantone_form +=   "</div>"
     pantone_form += "</div>"
     $("#pantone-colors-form").append(pantone_form)

  @removePantoneForm = (element) ->
     $(element).parent().parent().remove()
