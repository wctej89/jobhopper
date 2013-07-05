$(document).ready(function(){

  $('input').on('keyup', function(e){
    console.log(e.keyCode);
    if(e.keyCode == 188){
      var tag_array = $('.home-search').val().split(/,/).map(function(t){return t.trim()});
      var tag = tag_array[tag_array.length - 2];
      console.log(tag_array);
      console.log(tag);
      $.ajax({
        method: "GET", 
        url: '/search',
        data: "search=" + tag + "&page=" + 1
      }).success(function(response){
        console.log(response);
        $('.search-results').prepend(response)
      });
    }
    if(e.target.value === ''){
      console.log("Test")
      $('.search-results').html('');
    }
  });
});
