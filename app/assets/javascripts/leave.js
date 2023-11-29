// $(document).ready(function () {
//   // Check if the current page is the new employee page
//   if (window.location.pathname.includes('/leaves/new')) {
//     // Display an alert when the new employee page is loaded
//     alert('Do you want to create a new leave?');
//   }
// });

// for hajj and marriage


$(document).ready(function() {
  // Function to toggle the visibility of fields based on the selected leave type
  function toggleFieldsVisibility() {
    var leaveType = $('input[name="leave[leave_type]"]:checked').val();

    // Logic to show/hide fields based on leave type
    if (leaveType === 'Hajj' || leaveType === 'Marriage'){
      // If Hajj is selected, set duration as Long_Leave and duration type as Full_Day
      $('input[name="leave[duration]"][value="Long_Leave"]').prop('checked', true);
      $('input[name="leave[duration_type]"][value="Full_Day"]').prop('checked', true);

      // Hide duration and duration type fields
      $('#leave_duration_input, #leave_duration_type_input').hide();
    } else {
      // If a different leave type is selected, show duration and duration type fields
      $('#leave_duration_input, #leave_duration_type_input').show();

      // Uncheck duration and duration type radio buttons
      $('input[name="leave[duration]"]').prop('checked', false);
      $('input[name="leave[duration_type]"]').prop('checked', false);
    }
  }

  // Initial toggle on page load
  toggleFieldsVisibility();

  // Attach event handler to the leave type radio buttons
  $('input[name="leave[leave_type]"]').change(function() {
    toggleFieldsVisibility();
  });
});














// for one day and long leave


$(document).ready(function() {
  // Function to toggle the visibility of the end date based on duration
  function toggleEndDateVisibility() {
    var duration = $('input[name="leave[duration]"]:checked').val();
    var durationTypeCheckbox = $('#leave_duration_type_one_day');
    var startDateLabel = $('#leave_start_date_input label');

    if (duration === 'One_Day') {
      // If duration is One Day, hide end date and uncheck duration type
      $('#leave_end_date_input').hide();
      $('#leave_leave_days_input').hide();
      $('#leave_duration_type_input').show();
      startDateLabel.text('Select Date'); // Change label of start date
      durationTypeCheckbox.prop('checked', false);
    } else if (duration === 'Long_Leave') {
      // If duration is Long Leave, show end date and set duration type to Full Day
      $('#leave_end_date_input').show();
      $('#leave_leave_days_input').show();
      $('#leave_duration_type_input').hide();
      startDateLabel.text('Start Date'); // Change label of start date
      durationTypeCheckbox.prop('checked', true);
    } else {
      // If any other duration, show end date and duration type
      $('#leave_end_date_input').show();
      $('#leave_duration_type_input').show();
      startDateLabel.text('Start Date'); // Change label of start date
    }
  }

  // Initial toggle on page load
  toggleEndDateVisibility();

  // Attach event handler to the duration radio buttons
  $('input[name="leave[duration]"]').change(function() {
    toggleEndDateVisibility();
  });
});

// for get leaves days without weekends 


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
    var category = $('input[name="leave[category]"]:checked').val();

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

  // Attach event handlers to start date, end date, and category inputs
  $('#leave_start_date').on('change', function() {
    updateLeaveDays();
  });

  $('#leave_end_date').on('change', function() {
    updateLeaveDays();
  });

  $('input[name="leave[category]"]').on('change', function() {
    updateLeaveDays();
  });

  // Initial update on page load
  updateLeaveDays();
});






