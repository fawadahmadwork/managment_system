// $(document).ready(function () {
//   // Check if the current page is the new employee page
//   if (window.location.pathname.includes('/leaves/new')) {
//     // Display an alert when the new employee page is loaded
//     alert('Do you want to create a new leave?');
//   }
// });

// dynamically  get leave days excluding weekends


$(document).ready(function() {
  // Function to check if a date is a weekend (Saturday or Sunday)
  function isWeekend(date) {
    var day = date.getDay();
    return day === 0 || day === 6;
  }

  // Function to calculate and update leave days
  function updateLeaveDays() {
    var startDate = $('#leave_start_date').val();
    var endDate = $('#leave_end_date').val();
      var category = $('#leave_category').val();  

    if (startDate && endDate) {
      // Parse the date strings to Date objects
      var startDateObj = new Date(startDate);
      var endDateObj = new Date(endDate);

      // Initialize leave days to 0
      var leaveDays = 0;

      // Loop through each day between start date and end date
      var currentDate = new Date(startDateObj);
      while (currentDate <= endDateObj) {
        // Check if the current date is not a weekend, or if category is unpaid
        if (!isWeekend(currentDate) || category === 'Unpaid') {
          leaveDays++;
        }

        // Move to the next day
        currentDate.setDate(currentDate.getDate() + 1);
      }

      // Update the leave days input field
      $('#leave_leave_days').val(leaveDays);
    }
  }

    $('#leave_start_date, #leave_end_date, #leave_category').on('change', function() {
    updateLeaveDays();
  });

  // Initial update on page load
  updateLeaveDays();
});



// for hajj and marriage AND one_day vs long_leaves selection 


$(document).ready(function() {
  // Function to toggle the visibility of the end date and leave days based on duration
  function toggleEndDateAndLeaveDaysVisibility() {
    var duration = $('#leave_duration');
    var startDateLabel = $('#leave_start_date_input label');
    var endDateInput = $('#leave_end_date_input');
    var leaveDaysInput = $('#leave_leave_days_input');

    
   

    // Toggle based on duration value
    if (duration.val() === 'One_Day') {
      // If duration is One Day, hide end date and leave days
      endDateInput.hide();
      leaveDaysInput.hide();
      startDateLabel.text('Select Date');
      endDateInput.val('');
      $('#leave_leave_days').val('1');
      $('#leave_end_date').val('');
      $('#leave_start_date').val('');
      $('.inline-container').show();
    } else if (duration.val() === 'Long_Leave') {
      // If duration is Long Leave, show end date and leave days
      endDateInput.show();
      leaveDaysInput.show();
      startDateLabel.text('Start Date');
      $('.inline-container').hide();
    }
  }

  // Initial toggle on page load
  toggleEndDateAndLeaveDaysVisibility();

  // Attach event handler to the duration select element
  $('#leave_duration').change(function() {
    toggleEndDateAndLeaveDaysVisibility();
  });

  // Event handler for leave type change (assuming 'leave_leave_type' is your leave type select element)
  $('#leave_leave_type').change(function() {
    // Set the duration to 'Long_Leave' if leave type is 'Hajj'
   if ($(this).val() === 'Hajj' || $(this).val() === 'Marriage'){
      $('#leave_duration').val('Long_Leave').change();
      $('#leave_duration_input').hide();
      //  durationInput.hide();
    } else {
      // Reset the duration to 'One_Day' and trigger the toggle function for other leave types
      $('#leave_duration').val('One_Day').change();
      $('#leave_duration_input').show();
    }
  });
});














// working code with a error of hidden on filter reload

 $(document).ready(function() {
    // Hide the panels initially
    $('#monthly-logs-panel').hide();
    $('#weekly-logs-panel').hide();

    // Handle button click to toggle the monthly panel visibility and change button text
    $('#monthly-button').click(function() {
      $('#monthly-logs-panel').toggle();

      // Change button text based on panel visibility
      var buttonText = $('#monthly-logs-panel').is(':visible') ? 'Hide Monthly Logs' : 'Show Monthly Logs';
      $(this).text(buttonText);
    });

    // Handle button click to toggle the weekly panel visibility and change button text
    $('#weekly-button').click(function() {
      $('#weekly-logs-panel').toggle();

      // Change button text based on panel visibility
      var buttonText = $('#weekly-logs-panel').is(':visible') ? 'Hide Weekly Logs' : 'Show Weekly Logs';
      $(this).text(buttonText);
    });
 });
  




 




$(document).ready(function() {
  // Hide the "Other Source" field initially
  $('#other-source-field, label[for="other-source-field"]').hide();

  // Attach change event listener to the source select
  $('.source-select').change(function() {
    // Check if the selected value is 'Other'
    if ($(this).val() === 'Other') {
      // Show the "Other Source" field
      $('#other-source-field, label[for="other-source-field"]').show();
    } else {
      // Hide and clear the "Other Source" field
      $('#other-source-field, label[for="other-source-field"]').hide();
      $('#other-source-field').val('');
    }
  });

  // Trigger the change event to set the initial state
  $('.source-select').change();
});






  $(document).ready(function() {
      var checkbox = $('#show_external_rate_checkbox');
      var externalRateWrapper = $('#external_rate_wrapper');

      // Hide/show external_rate field based on checkbox state
      function toggleExternalRateField() {
        if (checkbox.prop('checked')) {
          externalRateWrapper.show();
        } else {
          externalRateWrapper.hide();
        }
      }

      // Initial state on page load
      toggleExternalRateField();

      // Toggle visibility on checkbox change
      checkbox.change(function() {
        toggleExternalRateField();
      });
    });