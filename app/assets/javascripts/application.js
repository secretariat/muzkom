// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_directory ./plugins

$(document).ready(function(){
  Pubsub.init();
  
  $('.slider').nivoSlider({
    animSpeed: 500,
    pauseTime: 5000,
    directionNavHide: true
  });
  
  $(".catalog .category").click(function(e){
    e.preventDefault();
    $(".subcategories").slideUp();
    $(this).parent().find(".subcategories").slideDown();
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
   var selector = $(this).attr('href');
   $('.tab-switcher a').removeClass('current');
   $(this).addClass('current');
   $('.tab-container .tab').hide();
   $(selector).fadeIn(200);
 });
 
 $('.edit-quantity').blur(function(){
    $(this).closest('form').submit();
  });
 
});
