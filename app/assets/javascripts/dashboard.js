$(document).ready(function(){

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
    e.preventDefault();
    var $job = $(this)
    $.ajax({
      type: 'put',
      url: '/jobs/'+ $job.attr('id')
    }).success(function(response){
      $job.parent().remove();
      console.log($job)
      $('.applied').append("<li>"+$job.siblings().first()
                          .text()+"</li><button>Submitted</button>")
    })
  })
 
});
