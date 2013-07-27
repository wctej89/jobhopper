$(document).ready(function(){

  $(document).on('click', '.crazy', function(){
    if($("#slideout").css("right") == "-285px"){
        $("#slideout").animate({right:'0px'}, {queue: false, duration: 500});
        $(this).animate({right:'245px'}, {queue: false, duration: 500});
    }else {
        $(this).animate({right:'-40px'}, {queue: false, duration: 500});
        $("#slideout").animate({right:'-285px'}, {queue: false, duration: 500});
    }
  });

  $(function() {
 
    $('.current-jobs').on('click', '.wrapper-dropdown-1', function() {
        // all dropdowns
        dd = new DropDown( $(this) );
        console.log("aofaflnlknln")
        $(this).toggleClass('active');
    });
  });
  
  function DropDown(el) {
      this.dd = el;
      this.placeholder = this.dd.children('span');
      this.opts = this.dd.find('ul.dropdown > li');
      this.val = '';
      this.index = -1;
      this.initEvents();
  }
  DropDown.prototype = {
      initEvents : function() {
          var obj = this;
   
          obj.dd.on('click', function(event){
              $(this).toggleClass('active');
              return false;
          });
   
          obj.opts.on('click',function(){
              var opt = $(this);
              obj.val = opt.text();
              obj.index = opt.index();
              obj.placeholder.text('Status: ' + obj.val);
          });
      },
      getValue : function() {
          return this.val;
      },
      getIndex : function() {
          return this.index;
      }
  }
  

  $(document).on('click', '.remove_tag', function(e){
    e.preventDefault();
    var $tag = $(this)
    $.ajax({
      type: 'delete',
      url: '/user_tags/' + $tag.attr('id')
    }).success(function(response){
      $tag.remove();
    });
  }); 

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

 $(".status-change-menu").on('click', '.status-change', function(e){
    e.preventDefault();
    var $job = $(this).parent();
    var message = $(this).text().trim().toLowerCase();
    var job_id = $(".remove_from_queue").attr('id');
    $.ajax({
      type: 'put',
      url: '/jobs/'+ $job.attr('id'),
      data: {status:$(this).text().trim()}
    }).success(function(response){
      // $('.applied').append($job);
      $('#slidecontent').find("#"+job_id).children().last().html("<p style='color: white; margin-top: 5px;'>Status: " + message + "</p>")
    });
  });
});
