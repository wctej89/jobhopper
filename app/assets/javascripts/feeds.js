function checkCookie(){
  if($.cookie("new_user") === "true")
  {
    loadColorbox();
  }
}

function loadColorbox(){
  console.log('foo');
  // $.colorbox({href:"/wizards/skills", open: true});
}

$(document).ready(function(){
  checkCookie();
});

