document.addEventListener('DOMContentLoaded', function() {
  // Check if it's a new form
  var isNewForm = !document.querySelector('form.formtastic').classList.contains('new_record');

  if (isNewForm) {
    var departmentSelect = document.getElementById('employee_department');
    var designationSelect = document.getElementById('employee_designation');

    var designationOptions = {
      'Development': ['Internee', 'Software Engineer', 'Software Engineer-L1', 'Software Engineer-L2'],
      'Quality Assurance': ['Internee-QA', 'SQA', 'Senior SQA']
    };

    departmentSelect.addEventListener('change', function() {
      var selectedDepartment = departmentSelect.value;
      var newOptions = designationOptions[selectedDepartment] || [];

      // Clear existing options
      while (designationSelect.options.length > 0) {
        designationSelect.remove(0);
      }

      // Add new options
      newOptions.forEach(function(value) {
        var option = new Option(value, value);
        designationSelect.add(option);
      });

      // Set selected designation based on saved value if not a new record
      if (!document.querySelector('form.formtastic').classList.contains('new_record')) {
        designationSelect.value = '<%= @employee.designation %>'; // Replace with your actual code
      }
    });

    departmentSelect.dispatchEvent(new Event('change')); // Initialize options on page load
  }
});



/ app/assets/javascripts/active_admin.js
document.addEventListener('DOMContentLoaded', function() {
  const avatarInput = document.getElementById('avatar-input');
  const avatarPreview = document.getElementById('avatar-preview');
  const avatarImage = document.getElementById('avatar-image');

  avatarInput.addEventListener('change', function() {
    const file = this.files[0];

    if (file) {
      const reader = new FileReader();

      reader.onload = function(e) {
        avatarImage.src = e.target.result;
        avatarPreview.style.display = 'block';
      };

      reader.readAsDataURL(file);
    } else {
      avatarImage.src = '';
      avatarPreview.style.display = 'none';
    }
  });
});

  