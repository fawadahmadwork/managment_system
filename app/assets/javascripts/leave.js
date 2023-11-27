//  for testing js working 

document.addEventListener('DOMContentLoaded', function () {
  
  // Check if the current page is the new employee page
  if (window.location.pathname.includes('/leaves/new')) {
    // Display an alert when the new employee page is loaded
    alert('Do you want to create a new leave?');
  }
});

//  for showing end date field and changing label of start date

document.addEventListener('DOMContentLoaded', function () {
  var endDateField = document.getElementById('leave_end_date');
  var endDateLabel = document.querySelector('label[for="leave_end_date"]');
  var totalDaysField = document.getElementById('leave_total_days');
  var totalDaysLabel = document.querySelector('label[for="leave_total_days"]');
  var startDateLabel = document.querySelector('label[for="leave_start_date"]');
  var durationField = document.getElementById('leave_duration'); // Replace with your actual ID

  function hideEndDate() {
    endDateField.style.display = 'none';
    if (endDateLabel) {
      endDateLabel.style.display = 'none';
    }
    totalDaysField.style.display = 'none';
    if (endDateLabel) {
      totalDaysLabel.style.display = 'none';
    }
    // Change the label of start date to 'Select Date'
    startDateLabel.textContent = 'Select Date';
  }

  function showEndDate() {
    endDateField.style.display = 'block'; // or 'inline' based on your layout
    if (endDateLabel) {
      endDateLabel.style.display = 'block';
    }
     totalDaysField.style.display = 'block';
    if (endDateLabel) {
      totalDaysLabel.style.display = 'block';
    }
    // Reset the label of start date
    startDateLabel.textContent = 'Start Date';
  }

  // By default, hide the end date and update the label of start date
  hideEndDate();

  // Add an event listener to the duration field
  durationField.addEventListener('change', function () {
    if (durationField.value === 'One_Day') {
      hideEndDate();
    } else if (durationField.value === 'Multiple_Days') {
      showEndDate();
    }
  });
});





document.addEventListener("DOMContentLoaded", function () {
  var startDateInput = document.getElementById("leave_start_date");
  var endDateInput = document.getElementById("leave_end_date");
  var totalDaysInput = document.getElementById("leave_total_days");
  var durationTypeInput = document.getElementById("leave_duration_type");

  $(startDateInput).datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect: updateTotalDays
  });

  $(endDateInput).datepicker({
    dateFormat: 'yy-mm-dd',
    onSelect: updateTotalDays
  });

  function updateTotalDays() {
    var startDate = $(startDateInput).datepicker('getDate');
    var endDate = $(endDateInput).datepicker('getDate');

    if (startDate && endDate) {
      var timeDiff = endDate.getTime() - startDate.getTime();
      var daysDiff = timeDiff / (1000 * 3600 * 24); // Total days as a decimal value

      // Update the total_days field
      if (durationTypeInput && durationTypeInput.value === "Half_Day") {
        var halfDayDiff = daysDiff - 0.5; // Subtract half a day
        totalDaysInput.value = halfDayDiff > 0 ? halfDayDiff : 0; // Ensure total_days is not negative
      } else {
        totalDaysInput.value = daysDiff;
      }
    } else {
      // If end_date is not provided, set total_days to default value (1)
      totalDaysInput.value = 1;
    }
  }

  // Set default value for end_date based on whether it's a new record or not
  if (endDateInput && endDateInput.value === "") {
    endDateInput.value = null; // Set to null for a new record
  }
});
