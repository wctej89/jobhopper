var Wizard = {
  init: function(){
    $('.delete').on("click",function(){
      $.ajax({
        url: '/user_tags/' + $(this).attr('id'),
        type: 'delete'
      });
      $(this).parent().remove();
    });
  }
};

$(document).ready(function(){
  Wizard.init();
});
