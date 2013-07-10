$(document).ready(function(){

  $('.job_show').on('click', '.show_add_to_queue', function(e){
    e.preventDefault();
    $target = $(this);
    $.ajax({
      method: 'post',
      url: $(this).parent().attr('href')
    }).success(function(response){
      console.log(response);
      $($target).removeClass('show_add_to_queue');
      $($target).addClass('remove_from_queue');
      $($target).text('Remove');
    });
  });

  $('.job_show').on('click', 'button.remove_from_queue', function(e){
    e.preventDefault();
    $removeButton = $(this);
    $.ajax({
      method: 'post',
      url: '/remove_from_queue/' + $(this).attr('id')
    }).success(function(response){
      $($removeButton).removeClass('remove_from_queue');
      $($removeButton).addClass('show_add_to_queue');
      $($removeButton).text('Add To Queue');
    });
  });

  // $('button.remove_from_queue').on('click', function(){
  //   $removeButton = $(this);
  //   $.ajax({
  //     method: 'post',
  //     url: '/remove_from_queue/' + $(this).attr('id')
  //   }).success(function(response){
  //     $($removeButton).removeClass('.remove_from_queue');
  //     $($removeButton).addClass('.show_add_to_queue');
  //     $($removeButton).text('Add To Queue');
  //   });
  // });

  // $('button.show_add_to_queue').on('click', function(e){
  //   e.preventDefault();
  //   $target = $(this);
  //   $.ajax({
  //     method: 'post',
  //     url: $(this).parent().attr('href')
  //   }).success(function(response){
  //     console.log(response);
  //     $($target).removeClass('.show_add_to_queue');
  //     $($target).addClass('.remove_from_queue');
  //     $($target).text('Remove');
  //   });
  // });
});