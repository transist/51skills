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
//= require jquery-ui
//= require jquery_ujs

//= require bootstrap
//= require mercury
//= require masonry
//= require mercury/support/history
//= require mercury/mercury
jQuery(top).trigger('initialize:frame');
var photo_count = 0;

$('a.upload_photo').live('click', function() {
  photo_count = photo_count + 1;
  var html = '<div class="clearfix upload"><label for="slide_'+photo_count+'"><img src="/assets/image_new.gif"/></label><div class="input"><input class="fileInput" name="slide[]" type="file"><a href="#" class="delete_upload">X</a<</div></div>';
  
  $("form#new_slide .actions").before(html);
})

$('a.delete_upload').live('click', function() {
  $(this).parent().parent().remove();
})