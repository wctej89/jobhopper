$(document).ready(function(){
  $("#queue_buttons").hover(function() { $(this).css("color", "#c0392b"); }, function(){$(this).css("color","rgb(90, 90, 90)")});

    $('#queue_buttons').on("click",function(){
       var $statusButton = $(this);
       console.log($statusButton);
      if($(this).attr("class") == "icon-ban-circle") {
        $.ajax({
          type: 'delete',
          url: '/remove_from_queue/' + $(".remove_from_queue").attr('id')
        }).success(function(response){
          $statusButton.attr("class", "icon-plus");
          $('#dd').css("display", "block");
        });
      } else {
        $.ajax({
          method: 'post',
          url: '/add_to_queue/' + $(".remove_from_queue").attr('id')
        }).success(function(response){
          $statusButton.attr("class", "icon-ban-circle");
          $('#dd').css("display", "none");

        });
      }
    });
  });