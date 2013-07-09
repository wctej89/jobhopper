$(document).ready(function(){
  if($.cookie("new_user")=== "true")
  {
    //TODO figure out how to make the skill page faster. (CACHE THE SHIT OUT OF IT)
    $.cookie("new_user", "false");
    $.colorbox({href:"/wizards/skills"});
  }




  $('.delete').on('click', function(){
    $.ajax({
      url: '/user_tags' + $(this).attr('id'),
      type: 'delete'
    });
    $(this).parent().remove();
  });
});