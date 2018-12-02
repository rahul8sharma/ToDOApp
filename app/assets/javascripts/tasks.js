$(document).on('click', '.project-task-edit', function(){
  $("#project_task_name_update_" + $(this).attr("data-projectTaskId")).show()
  $(this).hide()
});