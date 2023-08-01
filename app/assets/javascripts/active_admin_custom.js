// // app/assets/javascripts/active_admin_custom.js

// $(document).on('ready turbolinks:load', function() {
//   $('#date_of_birth_input').datepicker({
//     dateFormat: 'yy-mm-dd',
//     onSelect: function(dateText) {
//       var birthDate = new Date(dateText);
//       var now = new Date();
//       var age = now.getFullYear() - birthDate.getFullYear();
//       if (
//         now.getMonth() < birthDate.getMonth() ||
//         (now.getMonth() === birthDate.getMonth() && now.getDate() < birthDate.getDate())
//       ) {
//         age--;
//       }
//       $('#employee_age').val(age);
//     }
//   });
// });
