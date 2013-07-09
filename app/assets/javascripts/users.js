function getNewPage(){
  var page_num = parseInt($.cookie('page_num')) + 1
  $.cookie('page_num',page_num+1);
  if($(window).height() + $(window).scrollTop() + 150 > $(document).height()){
    $.ajax({
      method: "get",
      url: "/feed",
      data: "page=" + page_num
    }).done(function(response){
      console.log(response.results);
      var jobs = prepareResponse(response);
      var filledTemplate = Mustache.render($("#results").html(),{jobs: jobs.results});
      $('.jobs').append(filledTemplate);
      $('.desc').each(function(){$(this).text($(this).text().split(' ').slice(0,20).join(' ').concat('...'))});
      $('.more_info').each(function(){bindFirstLinkClick($(this))});
    });
  }
}

function getResults(page){
  $.ajax({
    method: 'get',
    url: '/feed?page=' + page
  }).done(function(jobs){
    var response = prepareResponse(jobs);
    removeKangaroo();
    var list = Mustache.render($('#results').html(),{jobs:response.results});
    $('.jobs').append(list);
    $('.desc').each(function(){$(this).text($(this).text().split(' ').slice(0,20).join(' ').concat('...'))});
    $('.more_info').each(function(){bindFirstLinkClick($(this))});
  });
}

function prepareResponse(jobs){
  for(i=0;i<jobs['results'].length;i++)
  {
    jobs['results'][i]['miles'] = jobs['miles'][i];
  }
  return jobs;
}

function removeKangaroo(){
  if($('.jobs').find('.kangaroo'))
  {
    $('.kangaroo').remove();
  }
}

function bindSecondLinkClick($self){
  $self.one("click",function(){
    $self.prev().text($self.prev().text().split(' ').slice(0,20).join(' ').concat('...'));
    $self.text('more info')
    bindFirstLinkClick($self);
  });
}

function bindFirstLinkClick($link){
  $link.off("click");
  $link.one("click",function(){
    console.log("hello");
    var $self = $(this);
    var job_id = $(this).closest('li').attr('id');
    $.ajax({
      url: '/get_job',
      data: 'job_id=' + job_id
    }).done(function(response){
      console.log(response.description);
      $self.prev().text(response.description);
      $self.text('less info');
      bindSecondLinkClick($self);
    });
  });
}

function fetchNewResults(){
  $.ajax({
    method: 'get',
    url: '/feed'
  }).success(function(jobs){
    if (jobs['results'][0].company == $('.job-info').find('h3').first().text())
    {
      var response = prepareResponse(jobs);
      console.log(response);
      //testing
      // var json = $.parseJSON('{"0": {"company": "Bonobos","created_at": "Fuck you","description": "Software engineer","id": "9600","miles": "1","name": "Rails Beast","updated_at": "Fuck you again"}}');
      response['results'][0] = json;
      Mustache.render($('#results').html(),{jobs:response.results});
    }
  });
}

$(document).ready(function(){
  $.cookie('page_num',1);
  var page_num = $.cookie('page_num');
  $('.jobs').append('<img class="kangaroo" src="/assets/kangourous-11.gif">');
  getResults(page_num);

  $('.feed_container').on('click', 'button.add_to_queue', function(e){
    var $target = e.target;
    e.preventDefault();
    $.ajax({
      method: 'post',
      url: $($target).attr('href')
    }).success(function(response){
      $($target).closest('li').fadeOut();
   });
  });
  
  setInterval(function(){
    fetchNewResults();
<<<<<<< HEAD
  }, 60000);

  $(window).on("scroll",_.debounce(getNewPage,200));
});
