function showFields(activeDiv) {
  $(activeDiv).show();
}

$(document).ready(function(){
  $("div").hide();
  $("div.default").show();
  $("#tabs li a").click(function(e){
    e.preventDefault();
    $("div").hide();
    showFields($(this).attr("href"));
  });
});


