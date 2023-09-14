$(document).ready( function() {
  var contributor_form = $("#contributor_form");

  contributor_form.on('submit',function(e){
    e.preventDefault();
    var form_data = new FormData(this);
    $.ajax({
      url: $(this).attr('action'),
      type: 'POST',
      data: form_data,
      processData: false,
      contentType: false,
      success: function(data){ 
        console.log(data);
      },
      error: function(error){
        console.log(error);
        $('#contributor_message').text('Something went wrong. Please try again later.');
        $('#contributor_error').show();
      }
    });
  });

  // error message close button
  $('#contributor_close_btn').on('click', function(){ $('#contributor_error').hide() });

  // success message close button
  $('#contributor_notice_close_btn').on('click', function(){ $('#contributor_notice').hide() });
});