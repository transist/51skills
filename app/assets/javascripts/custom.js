$(function() {
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

    $.ajax({
      type: 'post',
      headers: {
        'X-CSRF-Token': AUTH_TOKEN
      },
      complete: function(request){
        window.location = '/pages';
      },
      url: '/pages/'+id+ '/toggle_display'
    })
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
  };

  $('.btn .enroll').live('hover', function(){
    if(!_c_u_id){
      notice = '';
      if(locale == 'zh'){
        notice = '请先登入再进行此操作。'
      }else{
        notice = 'Please sign in.'
      }
      $(this).parent().toggleClass('disabled');
      $(this).attr('original-title', notice);
    }else{
      notice = '';
      if(locale == 'zh'){
        notice = '欢迎加入这个课堂！'
      }else{
        notice = 'welcome join this class'
      }
      $(this).parent().toggleClass('disabled');
      $(this).attr('original-title', notice);
    }
  });
});





