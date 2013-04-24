$(document).ready ->
  $("#display_delete_options").click ->
  	if $("#DeleteSelectedButton").css("display") == "none"
	    $(".delete_partial_zone").css("background-color", "#f1f7ff")
	   	$(".delete_partial_zone").css("display", "block")
	   	$("#DeleteSelectedButton").css("display", "block")
    else 
	    $(".delete_partial_zone").css("background-color", "#fff")
	   	$(".delete_partial_zone").css("display", "none")
	   	$("#DeleteSelectedButton").css("display", "none")
