// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.tokeninput
//= require parsley
//= require parsley.extend
//= require_tree .


$(function(){	
	var height = screen.height;
	console.log(height);
	$("div.post-main-page").css("min-height", height*0.74);
	$("div.devise-pages").css("min-height", height*0.74);
	
	$('input').customInput();
	$("label.first-label").addClass('checked');	

	$("#skill_input_box").tokenInput("/skills.json", {
    crossDomain: false,
    prePopulate: $("#skill_input_box").data("pre"),
    propertyToSearch: "name",
    theme: "facebook"
  });
});
