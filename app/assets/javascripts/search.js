$(document).ready(function(){

  // this is test functionality - not meant for production
  // reach out to a rails controller and get html partials here
  //render the html partials as li's in the search-results list
  $('.home-search').on('keyup', function(e){

    $('.search-results').append('<li><div class="job-info"><h1>The Best Job Ever</h1><h3><a href="http://company.com">Company name</a></div></h3><div class="job-buttons"><button>Not Relevant</button><button>Add to Queue</button></div></li>');
  });
});