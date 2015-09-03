
$("#project_select").empty()
  .append("<%= escape_javascript(render(:partial => @projects)) %>")
$("#project_select").prepend '<option value=\'\' selected=\'selected\'>Select Project</option>'
