$(document).ready(function() {

  $("#add-form").click(function(){
    var start_date = $('#invoice_start_date_filter').val();
    var end_date = $('#invoice_end_date_filter').val();
    var formClone = $('.form-data:first').clone();
    var start_date_picker = Math.floor(Math.random() * 1000);
    var end_date_picker = Math.floor(Math.random() * 1000);
    var due_date = Math.floor(Math.random() * 1000);

    formClone.find('#invoice_start_date').attr('id', start_date_picker);
    formClone.find('#' + start_date_picker).val(start_date);

    formClone.find('#invoice_end_date').attr('id', end_date_picker);
    formClone.find('#' + end_date_picker).val(end_date);

    formClone.find('#invoice_due_date').attr('id', due_date);

    if ($('.form-data').is(':visible')) {
      formClone.insertAfter(".form-data:last");
      }
    else {
      formClone.insertAfter("#main_content_wrapper");
    }
    $(".form-data:last").after($("#bulk-button"));
    $("#bulk-button").hide().show();

    return false;
  });

  $(document).on("click", "#remove-button", function(event) {
    $(this).closest('.form-data').hide();

    if ($('.form-data').is(':visible')) {
      $(".form-data:last").after($("#bulk-button"));
      $("#bulk-button").show();
    }
    else {
      $("#bulk-button").hide();
    }
  });

  $(document).on("click", "#bulk-button", function(event) {
    $('.form-data form').each(function (index, form) {
      // Submit the form using AJAX
      $.ajax({
        url: '/admin/invoices/create_multiple',
        method: 'POST',
        data: $(form).serialize(),
        success: function (data) {
        }
      });
    });
    window.location.href = '/admin/invoices'
  });

  $(document).on("change", '#invoice_project_id', function() {
    var due_field = $(this);
    $.ajax({
      url: '/admin/invoices/get_project',
      method: 'GET',
      data: { id: $(this).val() },
      dataType: 'json',
      success: function (data) {

        var  due_duration = data.due_duration
        var  end_date = $(due_field).parent().parent().find(':input:eq(3)').val();
        var  date = new Date(new Date(end_date).getTime() + due_duration * 24 * 60 * 60 * 1000).toISOString().split('T')[0];

        $(due_field).parent().parent().find(':input:eq(4)').val(date);

      }
    });
  });

  $(document).on("change", '#invoice_end_date_input', function() {

    var due_field = $(this);
    var id = $(this).parent().parent().find("#invoice_project_id").val();
    
    if(id){
      $.ajax({
        url: '/admin/invoices/get_project',
        method: 'GET',
        data: { id: id },
        dataType: 'json',
        success: function (data) {

          var  due_duration = data.due_duration
          var  end_date = $(due_field).parent().parent().find(':input:eq(3)').val();
          var  date = new Date(new Date(end_date).getTime() + due_duration * 24 * 60 * 60 * 1000).toISOString().split('T')[0];

          $(due_field).parent().parent().find(':input:eq(4)').val(date);

        }
      });
    }
  });

  $(document).on("input", '#invoice_hours', function() {
    var due_field = $(this);
    var id = $(this).parent().parent().find("#invoice_project_id").val();
    
    if(id){
      $.ajax({
        url: '/admin/invoices/get_project',
        method: 'GET',
        data: { id: id },
        dataType: 'json',
        success: function (data) {

          var  rate = data.rate;
          var  hours = due_field.val();
          var  amount = (hours * rate)

          $(due_field).parent().parent().find("#invoice_amount").val(amount);

        }
      });
    }
  });

});
