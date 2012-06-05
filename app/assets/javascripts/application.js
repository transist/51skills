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
//= require bootstrap-modal
//= require mercury
//= require masonry
//= require mercury/support/history
//= require mercury/mercury
//= require underscore
//= require wysihtml5
//= require advanced
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

$('a.toggle_display').live('click', function(){
  var id = $(this).attr('id');
  // alert(id)
  id = id.replace('page_', '');
  $.post('/pages/'+id+"/toggle_display", function() {
     window.location = '/pages';
  });
  return false;
})

var t = function(object, field) {
  return object[field+"_"+locale];
} 

$('#main_category_select').live('change', function(e){
  _category_id = e.target.selectedOptions[0].value;
  load_sub_categories(_category_id);
});

var load_sub_categories = function(_category_id){
  $('.sub-category').find('option').remove()

  $.get('/categories/'+ _category_id +"/sub_categories", function(categories) {
    var html = '';
    _.each(categories, function(category){
      chunk = "<option value='" + category.id + "'>" + t(category, 'name') + "</option>";
      html = html + chunk;
    });
    $('.sub-category').append(html);
  });
}

