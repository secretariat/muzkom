// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_directory ./plugins
//= require autocomplete-rails

$(document).ready(function(){
  Pubsub.init();
  
  $('.slider').nivoSlider({
    animSpeed: 500,
    pauseTime: 5000,
    directionNavHide: true
  });
  
  $(".catalog .category").click(function(e){
    e.preventDefault();
    if($(this).hasClass('current')){
      $(this).removeClass('current');
      $(this).parent().find(".subcategories").slideUp();
    }else{
      $(".subcategories").slideUp();
      $(this).addClass('current');
      $(this).parent().find(".subcategories").slideDown();
    }
 });
 
 $(".product-image-gallery .photo").click(function(e){
    e.preventDefault();
    var link = $(this).attr("href");
    $(".product-image-preview img").attr("src", link);
    $(".product-image-preview a").attr("for", $(this).attr("id"));
 });
 $(".product-image-preview a").click(function(e){
    e.preventDefault();
    if($("#photos_container").length != 0){
      var el = $(this).attr("for");
      $('#photos_container a').lightBox({overlayOpacity: 0.3});
      $('#photos_container a#'+el).click();
    }else{
      $(".product-image-preview a").lightBox({overlayOpacity: 0.3});
      $(".product-image-preview a").click();
    }
 });
 
 $("select[change=selectBrand]").change(function(){
   id = $(this).val();
   window.location.href = "/brands/"+id
 });
 $("select[change=submitForm]").change(function(){
    $(this).closest("form").submit();
 });
 
  $("a[rel=facebox]").facebox();
 
 $(".tab-switcher a").click(function(e){
   e.preventDefault();
   var value = $(this).attr("for");
   if(value != 'undefined'){
     setCookie("tab", value, 1);
   }
   var selector = $(this).attr('href');
   $('.tab-switcher a').removeClass('current');
   $(this).addClass('current');
   $('.tab-container .tab').hide();
   $(selector).fadeIn(200);
 });
 
 $('.edit-quantity').blur(function(){
    $(this).closest('form').submit();
  });
  
  $('.add-product-comment').click(function(e){
    e.preventDefault();
    var errors = false;
    if($("#product_comment_name").val() == ""){
      $("#product_comment_name").closest(".field").addClass("field_with_errors");
      errors = true
    }else{
      $("#product_comment_name").closest(".field").removeClass("field_with_errors");
    }
    if($("#product_comment_text").val() == ""){
      $("#product_comment_text").closest(".field").addClass("field_with_errors");
      errors = true
    } else{
        $("#product_comment_text").closest(".field").removeClass("field_with_errors");
      }
    if(errors == false){
      $(this).closest("form").submit();
    }
  });
  
  
  $('.add-publication-comment').click(function(e){
    e.preventDefault();
    var errors = false;
    if($("#publication_comment_name").val() == ""){
      $("#publication_comment_name").closest(".field").addClass("field_with_errors");
      errors = true
    }else{
      $("#publication_comment_name").closest(".field").removeClass("field_with_errors");
    }
    if($("#publication_comment_text").val() == ""){
      $("#publication_comment_text").closest(".field").addClass("field_with_errors");
      errors = true
    } else{
        $("#publication_comment_text").closest(".field").removeClass("field_with_errors");
      }
    if(errors == false){
      $(this).closest("form").submit();
    }
  });
 
});

function setCookie(name,value, days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
	return true;
}

