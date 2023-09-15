$(document).ready( function() {
  var categories_list = $('#categories_list');

  // error message close button
  $('#category_error_close_btn').on('click', function(){ $('#category_error').hide() });

  // CREATE
  $('#add_category_form').on('submit', function(e){
    e.preventDefault();
    var form_data = new FormData(this);
    var category_name = form_data.get('name').trim();
    if(category_name !== ''){
      // send ajax request
      ajax_request('/categories', 'POST', form_data);
    }else{
      set_category_error_message('Category name cannot be empty');
    }  
  });

    // UPDATE
    categories_list.on('click', '.category_edit_btn', function(){
    var update_btn = $(this);
    var confirm_btn = $(this).prev();
    var cancel_btn = confirm_btn.prev();
    var category_id = update_btn.data('category-id');
    update_btn.hide();
    confirm_btn.show();
    cancel_btn.show();
    var category_name_field = $(`#category_${category_id}`);
    category_name_field.prop('disabled', false);
    category_name_field.focus();
  });

  categories_list.on('click', '.category_cancel_btn', function(){
    var cancel_btn = $(this);
    var confirm_btn = cancel_btn.next();
    var update_btn = confirm_btn.next();
    var category_id = cancel_btn.data('category-id');
    var category_name = cancel_btn.data('category-name');
    var category_name_field = $(`#category_${category_id}`);
    category_name_field.prop('disabled', true);
    category_name_field.val(category_name);
    cancel_btn.hide();
    confirm_btn.hide();
    update_btn.show();
  });

  // Category update confirmation btn
  categories_list.on('click', '.category_confirm_btn', function(){
    var confirm_btn = $(this);
    var cancel_btn = confirm_btn.prev();
    var update_btn = confirm_btn.next();
    var category_id = cancel_btn.data('category-id');
    var category_name = cancel_btn.data('category-name');
    var category_name_field = $(`#category_${category_id}`);
    category_name_field.prop('disabled', true);
    cancel_btn.hide();
    confirm_btn.hide();
    if (category_name_field.val().trim() !== category_name) {
      var form_data = new FormData();
      form_data.append('name', category_name_field.val().trim());
      if(category_name_field.val().trim() !== '') ajax_request(`/categories/${category_id}`, 'PUT', form_data);
      else{
        category_name_field.val(category_name);
        set_category_error_message('Category name cannot be empty');
      }
    }
    update_btn.show();
  });

  // DELETE
  categories_list.on('click', '.fa-trash', function(){
    var category_id = $(this).data('category-id');
    if(confirm($(this).data('confirm'))) ajax_request(`/categories/${category_id}`, 'DELETE');
  });
  
});
function ajax_request(url, type, data = null){
  return $.ajax({
    url: url,
    type: type,
    data: data,
    processData: false,
    contentType: false,
    success: function(data){ console.log(data) },
    error: function(error){
      console.log(error);
      set_category_error_message('Something went wrong. Please try again later.');
    }
  });
}
function set_category_error_message(message){
  $('#category_error').show();
  $('#category_error_message').text(message);
}