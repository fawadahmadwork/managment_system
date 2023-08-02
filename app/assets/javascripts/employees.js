// app/assets/javascripts/employees.js
$(document).on('change', '#employee_department', function() {
  var department = $(this).val();
  var designationSelect = $('#employee_designation');
  
  if (department === 'Development') {
    designationSelect.html(
      '<option value="Intern">Intern</option>' +
      '<option value="L1 Software Engineer">L1 Software Engineer</option>' +
      '<option value="L2 Software Engineer - L3">L2 Software Engineer - L3</option>'
    );
  } else if (department === 'Quality Assurance') {
    designationSelect.html(
      '<option value="InternSQA">InternSQA</option>' +
      '<option value="Senior SQA">Senior SQA</option>'
    );
  } else {
    // Default options when no department is selected
    designationSelect.html(
      '<option value="">Select Designation</option>'
    );
  }
});
