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
        client_id: $("#client_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic client select OK!")

$(document).on 'change', '#role_select', (evt) ->
  $.ajax 'cascade/rate',
    type: 'GET'
    dataType: 'JSON'
    data: role_id: $('#role_select option:selected').val()
    error: (jqXHR, textStatus, errorThrown) ->
      console.log 'AJAX Error: ' + textStatus
    success: (data, textStatus, jqXHR) ->
      $('#timesheets_rate').val(data)
      $('#timesheets_is_billed_1').prop('checked', true)


$(document).on 'change', '#project_select', (evt) ->
  role = undefined
  $.ajax 'cascade/role',
    type: 'GET'
    dataType: 'JSON'
    data: project_id: $('#project_select option:selected').val()
    error: (jqXHR, textStatus, errorThrown) ->
      console.log 'AJAX Error: ' + textStatus
    success: (data, textStatus, jqXHR) ->
      role = $('#role_select')
      role.empty()
      role.prepend '<option value=\'\' selected=\'selected\'>Select role</option>'
      $.each data, (index, value) ->
        opt = undefined
        opt = $('<option/>')
        opt.attr 'value', value[0]
        opt.text value[1]
        opt.appendTo role
        return
      return
