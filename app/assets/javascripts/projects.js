function showFields(activeDiv) {
  $(activeDiv).show();
}

$(document).ready(function(){
  $("#tabs div").hide();
  $("#tabs div.default").show();
  $("#tabs li a").click(function(e){
    e.preventDefault();
    $("#tabs div").hide();
    showFields($(this).attr("href"));
  });
});


