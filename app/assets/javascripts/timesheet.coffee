# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.best_in_place').best_in_place()

$ ->
  $(document).on 'change', '#client_select', (evt) ->
    $.ajax 'cascade/project',
      type: 'GET'
      dataType: 'script'
      data: {
        client_name: $("#client_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic client select OK!")

$(document).on 'change', '#role_select', (evt) ->
  $.ajax 'cascade/rate',
    type: 'GET'
    dataType: 'JSON'
    data: role_name: $('#role_select option:selected').val()
    error: (jqXHR, textStatus, errorThrown) ->
      console.log 'AJAX Error: ' + textStatus
    success: (data, textStatus, jqXHR) ->
      $('#timesheets_rate').val(data)
      $('#timesheet_rate').val(data)