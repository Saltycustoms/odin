// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_nested_form
//= require best_in_place
//= require fcm_client_setup.js
//= require cable.js
//= require departments
//= require job_requests
//= require quotations
//= require packing_lists
//= require notifications
//= require products
//= require scripts/toolkit

$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();
});

$(document).on('turbolinks:load', function() {
    var sidebar = $('[data-sidebar]')
    pathing = sidebar.data("controller") + '-' + sidebar.data("action")
    $('[data-pathing=' + pathing + ']').addClass('active')
});
