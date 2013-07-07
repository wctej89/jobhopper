function getResults(page){
  $.ajax({
    method: 'get',
    url: '/feed?page=' + page
  }).done(function(response){
    removeKangaroo();
    renderResults(response);
  });
}

function removeKangaroo(){
  if($('.jobs').find('.kangaroo'))
  {
    $('.kangaroo').remove();
  }
}

function infiniteScroll(page_num){
  if($(window).height() + $(window).scrollTop() + 150 > $(document).height())
  {
    // Avanish please fix this
    console.log('hit infiniteScroll for' +  page_num);
    getResults(page_num);
  }
}

function renderResults(response){
  for(i=0; i< response["results"].length; i++)
  {
    $('.jobs').append(
      // Avanish please fix
      '<li id=' + response["results"][i].id + ', class="post"><h3>' + response["results"][i].name +'</h3></li><h3> Created ' + $.timeago(response["results"][i].created_at) +'</h3><h3>' + response["results"][i].company + '</h3><h3>' + Math.round(response["miles"][i]) + ' miles away</h3>'
      );
  }
}

$(document).ready(function(){
  var page_num = $.cookie('page_num');
  $('.jobs').append('<img class="kangaroo" src="/assets/kangourous-11.gif">');
  getResults(page_num);
  $(document).on("scroll",_.debounce(infiniteScroll(page_num+1), 200));
});