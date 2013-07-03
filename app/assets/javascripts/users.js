// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

  var data = [
  {
    value: 30,
    color:"#F38630"
  },
  {
    value : 50,
    color : "#E0E4CC"
  },
  {
    value : 100,
    color : "#69D2E7"
  }     
]

  var ctx = document.getElementById("myChart").getContext("2d");
  var myNewChart = new Chart(ctx).Pie(data);
  new Chart(ctx).Pie(data);

});
