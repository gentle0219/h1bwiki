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
	$('input[type="radio"]').customInput();
//	$('#authors_names_0').addClass("parsley-validated");
//	$('#authors_names_0').attr("data-mincheck", "1");

	$("label.radio label").removeClass("checked");
	$("label.first-label").addClass('checked');

	$("#skill_input_box").tokenInput("/skills.json", {
    crossDomain: false,
    prePopulate: $("#skill_input_box").data("pre"),
    propertyToSearch: "name",
    theme: "facebook"
  });
  var height = $(window).height();
	$("div.wrap").css("height", height*0.78);
	$(window).resize(function() {
  	var height = $(window).height();
		$("div.wrap").css("height", height*0.78);	
	});

	var pre_action = $("#job_post_form").attr("action");	
	$('#btn_post_preview').click(function(){		
		var preview = "/preview";
		var re = new RegExp("\/[a-z]*_[a-z]*[^\/]", "i");		
		var controller = pre_action.match(re);
		$("#job_post_form input[name='_method']").val("post")
		$("#job_post_form").attr("target", "_blink");
		$("#job_post_form").attr("action", controller+preview);
	});
	$('#btn_post_create').click(function(){
		$("#job_post_form input[name='_method']").val("put")
		$("#job_post_form").attr("target", "_self");
		$("#job_post_form").attr("action", pre_action);
	});

});
