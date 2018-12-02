$(document).on('click', '.project-edit', function(){
  $("#project_name_update_" + $(this).attr("data-projectId")).show()
  $(this).hide()
});