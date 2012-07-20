$(function(){

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
  
  $('.btn.watch_btn').click(function(e){
    if(_c_u_id == null){
      $('#auth_modal').modal('show');
      return false;
    };
  });
  
  $('.enroll_btn').click(function(e){
    if(_c_u_id == null){
      $('#auth_modal').modal('show');
      return false;
    };
  });
  
  if($('#main_category_select option:selected').attr('value')){
    load_sub_categories($('#main_category_select option:selected').attr('value'));
  };
  
  var editor1 = new wysihtml5.Editor("wysihtml5-textarea-summary-en", { // id of textarea element
    toolbar:      "wysihtml5-toolbar-summary-en", // id of toolbar element
    parserRules:  wysihtml5ParserRules // defined in parser rules set 
  });
  
  var editor2 = new wysihtml5.Editor("wysihtml5-textarea-summary-zh", { // id of textarea element
    toolbar:      "wysihtml5-toolbar-summary-zh", // id of toolbar element
    parserRules:  wysihtml5ParserRules // defined in parser rules set 
  });
  
  var editor3 = new wysihtml5.Editor("wysihtml5-textarea-description-en", { // id of textarea element
    toolbar:      "wysihtml5-toolbar-description-en", // id of toolbar element
    parserRules:  wysihtml5ParserRules // defined in parser rules set 
  });
  
  var editor4 = new wysihtml5.Editor("wysihtml5-textarea-description-zh", { // id of textarea element
    toolbar:      "wysihtml5-toolbar-description-zh", // id of toolbar element
    parserRules:  wysihtml5ParserRules // defined in parser rules set 
  });
  
  $( "#start_date_time_picker" ).datepicker({
    dateFormat : "yy-mm-dd",
    onSelect: function(dateText, inst) { $('.start_date_time_field').attr('value', dateText + ' 00:00:00') }
  });  

  $('#main_category_select').live('change', function(e){
    _category_id = $(this).val();
    load_sub_categories(_category_id);
  });

  console.log(gon.after_sign_up);
  
});