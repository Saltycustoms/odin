# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  $(".add-pic-button").click ->
    dept_url = $(this).data('dept-url')
    dept_name = $(this).data('dept-name')
    $("#add-pic-form").attr("action", dept_url)
    $("#add-pic-modal-dept-name").html(dept_name)
