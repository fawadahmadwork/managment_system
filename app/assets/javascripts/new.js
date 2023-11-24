// for update designation options based on the selected department

document.addEventListener('DOMContentLoaded', function () {
  var departmentSelect = document.getElementById('employee_department');
  var designationSelect = document.getElementById('employee_designation');
  var savedDesignation = designationSelect.getAttribute('data-saved-designation');

  var designationOptions = {
    'Development': ['Internee', 'Software Engineer', 'Software Engineer-L1', 'Software Engineer-L2'],
    'Quality Assurance': ['Internee', 'SQA', 'Senior SQA']
  };

  // Function to update designation options based on the selected department
  function updateDesignationOptions() {
    var selectedDepartment = departmentSelect.value;
    var newOptions = designationOptions[selectedDepartment] || [];

    // Clear existing options
    while (designationSelect.options.length > 0) {
      designationSelect.remove(0);
    }

    // Add new options
    newOptions.forEach(function (value) {
      var option = new Option(value, value);
      designationSelect.add(option);
    });

    // Select the saved designation if it's not empty
    if (savedDesignation && newOptions.includes(savedDesignation)) {
      designationSelect.value = savedDesignation;
    }
  }

  // Attach the event listener to the department select
  departmentSelect.addEventListener('change', updateDesignationOptions);

  // Initialize options on page load
  updateDesignationOptions();
});
  



// for id card

document.addEventListener('DOMContentLoaded', function () {
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

// for freezing date and comment 

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

// for mobile pattren

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

// for salary sum

document.addEventListener('DOMContentLoaded', function () {
  const basicSalaryInput = document.getElementById('salary_structure_basic_salary');
  const providentFundInput = document.getElementById('salary_structure_provident_fund');

  // Update provident fund when basic salary changes
  basicSalaryInput.addEventListener('input', function () {
    const basicSalary = parseFloat(this.value) || 0;
    const providentFund = (basicSalary * 0.05).toFixed(2);
    providentFundInput.value = providentFund;
  });
});


document.addEventListener('DOMContentLoaded', function() {
  const basicSalaryInput = document.getElementById('salary_structure_basic_salary');
  const fuelInput = document.getElementById('salary_structure_fuel');
  const medicalAllowanceInput = document.getElementById('salary_structure_medical_allownce');
  const houseRentInput = document.getElementById('salary_structure_house_rent');
  const opdInput = document.getElementById('salary_structure_opd');
  const arrearsInput = document.getElementById('salary_structure_arrears');
  const otherBonusInput = document.getElementById('salary_structure_other_bonus');
  const providentFundInput = document.getElementById('salary_structure_provident_fund');
  const grossSalaryInput = document.getElementById('salary_structure_gross_salary');
  const netSalaryInput = document.getElementById('salary_structure_net_salary');

  function updateCalculations() {
    const basicSalary = parseFloat(basicSalaryInput.value) || 0;
    const fuel = parseFloat(fuelInput.value) || 0;
    const medicalAllowance = parseFloat(medicalAllowanceInput.value) || 0;
    const houseRent = parseFloat(houseRentInput.value) || 0;
    const opd = parseFloat(opdInput.value) || 0;
    const arrears = parseFloat(arrearsInput.value) || 0;
    const otherBonus = parseFloat(otherBonusInput.value) || 0;

    const grossSalary = basicSalary + fuel + medicalAllowance + houseRent + opd + arrears + otherBonus;
    const providentFund = (basicSalary * 0.05).toFixed(2); // 5% of basic salary
    const netSalary = (grossSalary - providentFund).toFixed(2);

    grossSalaryInput.value = grossSalary.toFixed(2);
    providentFundInput.value = providentFund;
    netSalaryInput.value = netSalary;

    // Set read-only for the calculated fields
    providentFundInput.readOnly = true;
    netSalaryInput.readOnly = true;
    grossSalaryInput.readOnly = true;
  }

  // Attach event listeners to input fields
  [basicSalaryInput, fuelInput, medicalAllowanceInput, houseRentInput, opdInput, arrearsInput, otherBonusInput].forEach(input => {
    input.addEventListener('input', updateCalculations);
  });

  // Initial calculation
  updateCalculations();
});


//for age from date of birth

  document.addEventListener("DOMContentLoaded", function () {
    var dateOfBirthInput = document.getElementById("date-of-birth");
    var ageInput = document.getElementById("age");

    $(dateOfBirthInput).datepicker({
      changeMonth: true,
      changeYear: true,
      yearRange: '1970:2008',
      dateFormat: 'yy-mm-dd',
      onSelect: function (dateText) {
        var selectedDate = new Date(dateText);
        var currentDate = new Date();

        var age = currentDate.getFullYear() - selectedDate.getFullYear();
        if (
          currentDate.getMonth() < selectedDate.getMonth() ||
          (currentDate.getMonth() === selectedDate.getMonth() &&
            currentDate.getDate() < selectedDate.getDate())
        ) {
          age--;
        }

        ageInput.value = age;
      }
    });
  });

// for salary slip data sum

  document.addEventListener('DOMContentLoaded', function() {
  const basicSalaryInput = document.getElementById('salary_slip_basic_salary');
  const fuelInput = document.getElementById('salary_slip_fuel');
  const medicalAllowanceInput = document.getElementById('salary_slip_medical_allownce');
  const houseRentInput = document.getElementById('salary_slip_house_rent');
  const opdInput = document.getElementById('salary_slip_opd');
  const arrearsInput = document.getElementById('salary_slip_arrears');
  const otherBonusInput = document.getElementById('salary_slip_other_bonus');
  const providentFundInput = document.getElementById('salary_slip_provident_fund');
  const grossSalaryInput = document.getElementById('salary_slip_gross_salary');
  const netSalaryInput = document.getElementById('salary_slip_net_salary');

  function updateCalculations() {
    const basicSalary = parseFloat(basicSalaryInput.value) || 0;
    const fuel = parseFloat(fuelInput.value) || 0;
    const medicalAllowance = parseFloat(medicalAllowanceInput.value) || 0;
    const houseRent = parseFloat(houseRentInput.value) || 0;
    const opd = parseFloat(opdInput.value) || 0;
    const arrears = parseFloat(arrearsInput.value) || 0;
    const otherBonus = parseFloat(otherBonusInput.value) || 0;

    const grossSalary = basicSalary + fuel + medicalAllowance + houseRent + opd + arrears + otherBonus;
    const providentFund = (basicSalary * 0.05).toFixed(2); // 5% of basic salary
    const netSalary = (grossSalary - providentFund).toFixed(2);

    grossSalaryInput.value = grossSalary.toFixed(2);
    providentFundInput.value = providentFund;
    netSalaryInput.value = netSalary;

    // Set read-only for the calculated fields
    providentFundInput.readOnly = true;
    netSalaryInput.readOnly = true;
    grossSalaryInput.readOnly = true;
  }

  // Attach event listeners to input fields
  [basicSalaryInput, fuelInput, medicalAllowanceInput, houseRentInput, opdInput, arrearsInput, otherBonusInput].forEach(input => {
    input.addEventListener('input', updateCalculations);
  });

  // Initial calculation
  updateCalculations();
});



// for avatar preview

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



