$(document).ready(function(){

  $(document).on('click', 'button.add_to_queue', function(e){
    e.preventDefault();
    var $target = e.target;
    e.preventDefault();
    console.log($($target));
    $.ajax({
      method: 'post',
      url: '/user_tags/',
      data: {"id":$(this).attr('id')}
    }).success(function(response){
      $($target).closest('li').fadeOut();
      $('.skills-list').append('<button>' + $($target).parent().parent().find('h1').text() +'</button>');
    });
  });

  $('.wizard-search').on('keyup', _.debounce(function(e){
      e.preventDefault();
    if(e.keyCode == 8)
      {
        $('.search_results').html('');
      }
      else
      {
        $.ajax({
        method: 'get',
        url: '/search_tags',
        data: $(this).serialize()
      }).success(function(response){
        console.log(response);
        for(i=0;i<=response.length;i++)
        {
          $('.search_results').append(
            '<li><div class="job-info"><h1>' + response[i].name + '</h1><div class="buttons"><button id='+ response[i].id +' class="add_to_queue" href="/user_tags/">Add Skill</button></div></li>'
            );
        }
      });
    }
  }));
});