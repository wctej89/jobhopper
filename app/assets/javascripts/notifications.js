function fetchNotifications(){
  $.ajax({
    method: 'get',
    url: '/notifications'
  }).success(function(response){
    console.log(response);
    $('span.notification_count').text(response.length);
  });
}

$(document).ready(function(){
  fetchNotifications();
  setInterval(function(){
    fetchNotifications();
  }, 50000);
});