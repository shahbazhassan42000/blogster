$(document).ready( function() {
  var comment_form = $("#comment_form");
  var comment_modal = $('#comment_modal');
  var comment_text_field = $("#comment_text_field");

  comment_form.on('submit',function(e){
    e.preventDefault();
    var form_data = new FormData(this);
    if(comment_text_field.val().trim() !== ''){
      ajax_request('/comments', 'POST', form_data);
    }else{
      set_comment_error_message("Comment can't be blank");
      comment_text_field.val("");
    }
  });

   // open modal
   $("#add_comment_btn").on('click', function(){ comment_modal.show() });

   // error message close button
  $('#comment_error_close_btn').on('click', function(){ $('#comment_error').hide() });

   $("#modal_close_btn, #modal_cancel_btn").on('click', function(e){ 
    e.preventDefault();
    comment_text_field.val("");
    comment_modal.hide();
  });
  
});

function ajax_request(url, type, data = null){
  return $.ajax({
    url: url,
    type: type,
    data: data,
    processData: false,
    contentType: false,
    success: function(data){ 
      console.log(data);
      // comment_modal.hide();
    },
    error: function(error){
      console.log(error);
      set_comment_error_message('Something went wrong. Please try again later.');
    }
  });
}
function set_comment_error_message(message){
  $('#comment_error').show();
  $('#comment_error_message').text(message);
}