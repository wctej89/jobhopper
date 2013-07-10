$(document).ready(function(){
//commit

  $(document).on('click', '.crazy', function(){
    if($("#slideout").css("right") == "-285px"){
        $("#slideout").animate({right:'0px'}, {queue: false, duration: 500});
        $(this).animate({right:'245px'}, {queue: false, duration: 500});
    }else {
        $(this).animate({right:'-37px'}, {queue: false, duration: 500});
        $("#slideout").animate({right:'-285px'}, {queue: false, duration: 500});
    }
  });
  

  $(document).on('click', '.remove_tag', function(e){
    e.preventDefault();
    var $tag = $(this)
    $.ajax({
      type: 'delete',
      url: '/user_tags/' + $tag.attr('id')
    }).success(function(response){
      $tag.remove();
    });
  }); 

 $(document).on('click', '.remove_from_queue', function(e){
    e.preventDefault();
    var job = this
    $.ajax({
      method: "GET",
      url: $(this).attr('href')
    }).success(function(response){
      $(job).closest('li').remove();
    });
  });

 $(document).on('click', '.apply', function(e){
    var $job = $(this).parent();
    $.ajax({
      type: 'put',
      url: '/jobs/'+ $job.attr('id')
    }).success(function(response){
      $('.applied').append($job)
    });
  });
});
