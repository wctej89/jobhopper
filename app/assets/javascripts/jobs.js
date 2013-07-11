$(document).ready(function(){
  $("#queue_buttons").hover(function() { $(this).css("color", "#c0392b"); }, function(){$(this).css("color","rgb(90, 90, 90)")});

    $('#queue_buttons').on("click",function(){
       var $statusButton = $(this);
       var job_id = $(".remove_from_queue").attr('id');
       console.log(job_id);
       var job_title = $("h1").last().text();
       var company_name = $("h4").last().text();
       debugger
      if($(this).attr("class") == "icon-ban-circle") {
        $.ajax({
          type: 'delete',
          url: '/remove_from_queue/' + $(".remove_from_queue").attr('id')
        }).success(function(response){
          $statusButton.attr("class", "icon-plus");
          $('#dd').css("display", "none");
          $('#slidecontent').find("#"+job_id).remove();
        });
      } else {
        $.ajax({
          method: 'post',
          url: '/add_to_queue/' + $(".remove_from_queue").attr('id')
        }).success(function(response){
          $statusButton.attr("class", "icon-ban-circle");
          $('#dd').css("display", "block");
          $( ".crazy" ).effect( "pulsate", {times: 1},1200);
          $('#slidecontent').append("<li class='queued-job' id=" + job_id + " style='list-style: none;'><div><h5><a href='/jobs/" + job_id + "'>" + job_title + "</a></h5><p style='color: white;'>" + company_name + "</p></div><div class='buttons'><p style='color: white; margin-top: 5px;'>Status: pending</p></div></li>");
        });
      }
    });
  });