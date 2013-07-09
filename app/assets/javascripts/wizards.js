$(document).ready(function(){

  $('.delete').on('click', function(){
    $.ajax({
      url: '/user_tags' + $(this).attr('id'),
      type: 'delete'
    });
    $(this).parent().remove();
  });
});