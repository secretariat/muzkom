//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.form
//= require jquery.remotipart
//= require tinymce-jquery
//= require_directory ./plugins

$(document).ready(function(){
  $('a[rel=facebox]').facebox();
  $("#tab-switcher").uiTabs();
  $('.chzn-select').chosen();
  $( "#categories, #subcategories" ).sortable({
    axis: 'y',
    handle: '.checkbox',
    update: function(){
      $.post($(this).data("update-url"), $(this).sortable('serialize'));
    }
  });
  $('.flash_message').delay(300).animate({'top': 0}, 500).delay(2000).fadeOut(500);  
  $('.edit-price').blur(function(){
    $(this).closest('form').submit();
  });
  $(".catalog .category").click(function(e){
    e.preventDefault();
    $(".subcategories").slideUp();
    $(this).parent().find(".subcategories").slideDown();
  });
  
  $('#promotion-selector').change(function(){
    if($(this).val() == null){
      $('#sale-price #product_sale_price').val("0.0");
      $('#sale-price').addClass('hidden');
    }else{
      $('#sale-price').removeClass('hidden');
    }
  });
  
  $('.text.disabled').attr("disabled", "disabled");
 
  $('.placement').change(function(){
    var el = $(this).parent().parent().find(".text");
    if($(this).attr("checked") == "checked"){
      el.removeClass('hidden');
      el.removeAttr("disabled");
    }else{
      el.addClass('hidden');
      el.attr("disabled", "disabled");
    }
  }); 
  
  
  
});
  
tinyMCE.init({
  mode : "exact",
  elements : "short-pannel",
  theme : "advanced",
  theme_advanced_toolbar_location : "top",
  theme_advanced_toolbar_align : "left",
  theme_advanced_buttons1 : "bold,italic,underline,|,justifyleft,justifycenter,justifyright,justifyfull,|,link,unlink",
  theme_advanced_buttons2 : "",
  theme_advanced_buttons3 : ""
});

tinyMCE.init({
  mode : "exact",
  elements : "pannel",
  theme : "advanced",
  plugins : "autosave, paste, fullscreen",
  theme_advanced_toolbar_location : "top",
  theme_advanced_toolbar_align : "left",
  theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,forecolor,backcolor",
  theme_advanced_buttons2 : "bullist,numlist,|,link,unlink,|,outdent,indent,blockquote,|,image,cleanup,|,code,fullscreen",
  theme_advanced_buttons3 : "",
});

jQuery.fn.uiTabs = function(){
  var tabs = $(this).find("li:not('.inactive')");
  var current_tab = $(this).find("li#current");
  var containers = $.find("div[id^=tab]");
  $(containers).hide();
  $("#"+$(current_tab).attr("for")).show();
  $(tabs).click(function(){
    $("#"+$(current_tab).attr("for")).hide();
    $("#"+$(this).attr("for")).fadeIn(400);
    $(current_tab).attr("id", "");
    $(this).attr("id", "current")
    current_tab = $(this);
  });
}