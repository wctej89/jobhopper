$(document).ready(function(){
//commit

  $(document).on('click', '.crazy', function(){
    if($("#slideout").css("right") == "-340px"){
        $(this).animate({right:'286px'}, {queue: false, duration: 500});
        $("#slideout").animate({right:'0px'}, {queue: false, duration: 500});
    }else {
        $(this).animate({right:'298px'}, {queue: false, duration: 500});
        $("#slideout").animate({right:'-340px'}, {queue: false, duration: 500});
    }
  });

  $(function() {
 
    var dd = new DropDown( $('#dd') );
 
    $(document).click(function() {
        // all dropdowns
        $('.wrapper-dropdown-1').removeClass('active');
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

 $(document).on('click', '.apply', function(e){
    var $job = $(this).parent();
    $.ajax({
      type: 'put',
      url: '/jobs/'+ $job.attr('id')
    }).success(function(response){
      $('.applied').append($job)
    });
  });
});
