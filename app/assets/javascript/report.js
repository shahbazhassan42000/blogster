$(document).ready( function() {
  if(!$('#report_table_length').length) {
    var table = $('#report_table').DataTable({
      initComplete: function () {
          var api = this.api();

          // Blog title filter
          $('.title-filter').off('keyup change').on('change',function(e) {
            var regex = '({search})';
            var cursorPosition = this.selectionStart;
            // Search the column for that value
            api.column(0).search(
              this.value != ''
              ? regex.replace('{search}', '(((' + this.value + ')))')
              : '',
              this.value != '',
              this.value == ''
            ).draw();
          }).on('keyup', function (e) {
            e.stopPropagation();
            $(this).trigger('change');
            $(this).focus()[0].setSelectionRange(cursorPosition, cursorPosition);
          });

          // Blog author filter
          $('.author-filter').off('keyup change').on('change',function(e) {
            var regex = '({search})';
            var cursorPosition = this.selectionStart;
            // Search the column for that value
            api.column(3).search(
              this.value != ''
              ? regex.replace('{search}', '(((' + this.value + ')))')
              : '',
              this.value != '',
              this.value == ''
            ).draw();
          }).on('keyup', function (e) {
            e.stopPropagation();
            $(this).trigger('change');
            $(this).focus()[0].setSelectionRange(cursorPosition, cursorPosition);
          });
      }
    });
    
    $('#filters_clear_btn').on('click', function(){
      $('.title-filter').val('');
      $('.author-filter').val('');
      table.column(0).search('').draw();
      table.column(3).search('').draw();
    });
  }
});