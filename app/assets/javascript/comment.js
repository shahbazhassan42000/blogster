$(document).ready( function() {
  var comment_form = $('#comment_form');
  var comment_modal = $('#comment_modal');
  var comment_text_field = $("#comment_text_field");
  var comments_list = $('#comments_list');
  
  //UPDATE
  comments_list.on('click', '.comment_edit_btn', function(){
    var update_btn = $(this);
    var confirm_btn = $(this).prev();
    var cancel_btn = confirm_btn.prev();
    var comment_id = update_btn.data('comment-id');
    update_btn.hide();
    confirm_btn.show();
    cancel_btn.show();
    var comment_message_field = $(`#${comment_id} p`);
    comment_message_field.attr('contenteditable','true');
    comment_message_field.focus();
  });

  comments_list.on('click', '.comment_cancel_btn', function(){
    var cancel_btn = $(this);
    var confirm_btn = cancel_btn.next();
    var update_btn = confirm_btn.next();
    var comment_id = cancel_btn.data('comment-id');
    var comment_content = cancel_btn.data('comment-content');
    var comment_message_field = $(`#${comment_id} p`);
    comment_message_field.html($.parseHTML(comment_content));
    comment_message_field.attr('contenteditable','false');
    cancel_btn.hide();
    confirm_btn.hide();
    update_btn.show();
    console.log("cancel button")
  });

  // Comment update confirmation btn
  comments_list.on('click', '.comment_confirm_btn', function(){
    var confirm_btn = $(this);
    var cancel_btn = confirm_btn.prev();
    var update_btn = confirm_btn.next();
    var comment_id = cancel_btn.data('comment-id');
    var comment_content = cancel_btn.data('comment-content');
    var comment_message_field = $(`#${comment_id} p`);
    comment_message_field.attr('contenteditable','false');
    cancel_btn.hide();
    confirm_btn.hide();
    if (comment_message_field.text().trim() !== comment_content) {
      var form_data = new FormData();
      form_data.append('content', comment_message_field.text().trim());
      if(comment_message_field.text().trim() !== '') ajax_request(`/comments/${comment_id}`, 'PUT', form_data);
      else{
        comment_message_field.html($.parseHTML(comment_content));
        set_comment_error_message("Comment can't be blank", 'PUT');
      }
    }
    update_btn.show();
  });


  // CREATE
  comment_form.on('submit',function(e){
    e.preventDefault();
    var form_data = new FormData(this);
    if(comment_text_field.val().trim() !== ''){
      ajax_request('/comments', 'POST', form_data);
    }else{
      set_comment_error_message("Comment can't be blank", 'POST');
      comment_text_field.val("");
    }
  });

  // DELETE
  comments_list.on('click', '.comment_delete_btn', function(){
    var comment_id = $(this).data('comment-id');
    if(confirm($(this).data('confirm'))) ajax_request(`/comments/${comment_id}`, 'DELETE');
  });

   // open modal
  $('#add_comment_btn').on('click', function(){ 
    comment_modal.show();
    $('#header').css('z-index', '0');

  });

   // error message close button
  $('#comment_error_close_btn').on('click', function(){ $('#comment_error').hide() });
  
  // errors message close button
  $('#comments_error_close_btn').on('click', function(){ $('#comments_error').hide() });

  // notice message close button
  $('#comments_notice_close_btn').on('click', function(){ $('#comments_notice').hide() });

  $("#modal_close_btn, #modal_cancel_btn").on('click', function(e){ 
    e.preventDefault();
    comment_text_field.val("");
    comment_modal.hide();
    $('#header').css('z-index', '1021');
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
      set_comment_error_message('Something went wrong. Please try again later.', type);
    }
  });
}
function set_comment_error_message(message, type){
  if(type === 'POST'){
    $('#comment_error_message').text(message);
    $('#comment_error').show();
  }
  else{
    $('#comments_error_message').text(message);
    $('#comments_error').show();
  }
  
}

