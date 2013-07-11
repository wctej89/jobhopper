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
      $('.skills-list').append('<button>' + $($target).parent().parent().find('h3').text() +'</button>');
    });
  });

  $('.wizard-search').on('keyup', _.debounce(function(e){
      e.preventDefault();
    if(e.keyCode == 8)
      {
        $('.tag_results').html('');
      }
      else
      {
        $.ajax({
        method: 'get',
        url: '/search_tags',
        data: $(this).serialize()
      }).success(function(response){
        for(i=0;i<response.length;i++)
        {
          $('.tag_results').append(
            '<li><div class="tag-info"><div class="tag-name"><h3>' + response[i].name + '</h3></div><div class="tag-buttons"><button id='+ response[i].id +' class="add_to_queue" href="/user_tags/">Add Skill</button></div></li>'
            );
        }
      });
    }
  }, 300));

  // $('.next').on('click', function(e){
  //   e.preventDefault();
  //   $.ajax({
  //     method: 'get',
  //     url: '/wizards/locations'
  //   }).success(function(response){
  //     console.log(response);
  //     $('html').html(response);
  //   });
  // });
});