$(document).ready(function(){
  $('.has-flyout').on('click',function(e){
    $('.notifications').toggle();
  });

  $('li.notification').on('click', function(e){
    var $notification = $(this);
    var notification_count = parseInt($('span.notification_count').text());
    e.preventDefault();
    $.ajax({
      method: 'delete',
      url: '/notifications/' + $(this).attr('id')
    }).success(function(response){
      $($notification).remove();
      $('span.notification_count').text(notification_count+=-1);
    });
  });
});