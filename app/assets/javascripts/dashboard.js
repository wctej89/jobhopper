$(document).ready(function(){

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

});
