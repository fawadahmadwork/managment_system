// app/assets/javascripts/national_id_card_format.js

$(document).on('input', '[name="employee[national_id_card]"]', function () {
  var inputValue = $(this).val().trim();
  var formattedValue = inputValue.replace(/(\d{5})(\d{7})(\d{1})/, '$1-$2-$3');
  $(this).val(formattedValue);
});
