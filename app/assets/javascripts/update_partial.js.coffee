$(document).ready ->
  $("#display_update_options").click ->
  	if $("#UpdateSelectedButton").css("display") == "none"
	    $(".update_multiple_wrapper").css("display", "block")
	    $("#UpdateSelectedButton").css("display", "block")
	   	$(".update_partial_zone").css("display", "block")
	   	$(".update_partial_zone").css("background-color", "#f1f7ff")
    else 
    	$(".update_multiple_wrapper").css("display", "none")
    	$("#UpdateSelectedButton").css("display", "none")
	   	$(".update_partial_zone").css("background-color", "#FFF")

