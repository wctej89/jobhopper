$(document).ready(function(){

  $('.wizard-search').on('keyup',_.debounce(function(e){
    e.preventDefault();
    $.ajax({
      method: 'get',
      url: '/search_tags',
      data: $(this).serialize()
    }).success(function(response){
      console.log(response);
      for(i=0;i<=response.length;i++)
      {
        $('.search_results').append('<li><div class="job-info"><h1>' + response[i].name + '</h1><div class="buttons"></div></li>');
      }
    });

    if($('.wizard-search').val() === '')
    {
      $('.search_results').html('');
    }
  }));
});