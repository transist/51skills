$(function(){
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
  

});