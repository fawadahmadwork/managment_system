document.addEventListener('DOMContentLoaded', function() {
  var departmentSelect = document.getElementById('employee_department');
  var designationSelect = document.getElementById('employee_designation');

  var designationOptions = {
    'Development': ['Internee', 'Software Engineer', 'L1, Software Engineer', 'L2, Software Engineer'],
    'Quality Assurance': ['Internee QA', 'SQA', 'Senior SQA']
  };

  function updateDesignationOptions() {
    var selectedDepartment = departmentSelect.value;
    var newOptions = designationOptions[selectedDepartment] || [];
    designationSelect.innerHTML = ''; 
    newOptions.forEach(function(value) {
      var option = document.createElement('option');
      option.text = value;
      option.value = value;
      designationSelect.appendChild(option);
    });
  }

  departmentSelect.addEventListener('change', updateDesignationOptions);
  updateDesignationOptions();
});

document.addEventListener('DOMContentLoaded', function() {
  const nationalIdInput = document.getElementById('employee_national_id_card');

  if (nationalIdInput) {
    nationalIdInput.addEventListener('input', function() {
      const inputValue = nationalIdInput.value;
      let formattedValue = inputValue.replace(/[^0-9]/g, ''); // Remove non-numeric characters

      if (formattedValue.length >= 5 && formattedValue.length <= 12) {
        formattedValue = formattedValue.substring(0, 5) + '-' + formattedValue.substring(5);
      } else if (formattedValue.length >= 13) {
        formattedValue =
          formattedValue.substring(0, 5) +
          '-' +
          formattedValue.substring(5, 12) +
          '-' +
          formattedValue.substring(12);
      }

      nationalIdInput.value = formattedValue;
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const employmentStatusInput = document.getElementById('employee_employment_status');
  const freezingDateInput = document.getElementById('employee_freezing_date');
  const freezingCommentInput = document.getElementById('employee_freezing_comment');

  function toggleFreezeFields() {
    if (employmentStatusInput.value === 'Freeze') {
      freezingDateInput.closest('.input').style.display = 'block';
      freezingCommentInput.closest('.input').style.display = 'block';
    } else {
      freezingDateInput.closest('.input').style.display = 'none';
      freezingCommentInput.closest('.input').style.display = 'none';
    }
  }

  toggleFreezeFields();
  employmentStatusInput.addEventListener('change', toggleFreezeFields);
});



document.addEventListener('DOMContentLoaded', function() {
  const phoneNumberInput = document.getElementById('phone_number_input_id'); // Replace with the actual ID of your phone number input

  if (phoneNumberInput) {
    phoneNumberInput.addEventListener('input', function() {
      const inputValue = phoneNumberInput.value;
      let formattedValue = inputValue.replace(/[^0-9]/g, ''); // Remove non-numeric characters

      if (formattedValue.length > 10) {
        formattedValue = formattedValue.substring(0, 11);
      }

      if (formattedValue.length >= 4) {
        formattedValue = formattedValue.substring(0, 4) + '-' + formattedValue.substring(4);
      }

      phoneNumberInput.value = formattedValue;
    });
  }
});
