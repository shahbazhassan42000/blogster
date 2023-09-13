$(document).ready( function() {
  var company_name_field = $('#company_name_field');
  var slug_view = $('#slug_view');
  var slug_box = $('#slug_box');

  // setting company slug/subdomain
  company_name_field.on('input', function(){
    var company_name = company_name_field.val().trim();
    if(company_name !== ''){
      company_name = company_name.replace(/[^a-zA-Z0-9]/g, '').toLowerCase();
      slug_view.text(company_name);
      slug_box.show();
    }else{
      slug_box.hide();
    }
  });
});