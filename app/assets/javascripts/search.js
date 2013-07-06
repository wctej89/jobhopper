function shitFuck(){
  if($(window).height() + $(window).scrollTop() + 150 > $(document).height()){
    var page_num = $.cookie('page_num')
    var search_term = $.cookie('search_term')
    $.ajax({
      method: "get",
      url: "search",
      data: "search=" + search_term + "&page=" + page_num
    }).done(function(response){
      $.cookie('page_num',parseInt(page_num)+1);
      $('.search-results').append(Mustache.render($("#results").html(),{jobs: response}));
    });
  }
}

$(document).ready(function(){
  $.cookie('page_num','0');
  
  $(window).on("scroll",_.debounce(shitFuck,200));


  function checkInput(e){
    console.log(e.keyCode);
    if(e.keyCode == 188){
      var tag_array = $('.home-search').val().split(/,/).map(function(t){return t.trim()});
      var tag = tag_array[tag_array.length - 2];
      console.log(tag_array);
      console.log(tag);
      $.ajax({
        method: "GET", 
        url: '/search',
        data: "search=" + tag + "&page=1"
      }).success(function(response){
        console.log(response);
        x = {jobs: response}
        $('.search-results').prepend(Mustache.render($("#results").html(),{jobs: response}))
        $.cookie('search_term',tag);
        $.cookie('page_num',2);
      });
    }
    if(e.target.value === ''){
      $('.search-results').html('');
      $.cookie('page_num','');
    }
  }

  $('input').on('keyup', _.debounce(checkInput,100));

  $(document).on('click', '.add_to_queue', function(e){
    e.preventDefault();
    var job = this
    $.ajax({
      method: "GET",
      url: $(this).attr('href')
    }).success(function(response){
      $(job).closest('li').remove();
    });

  });
});
