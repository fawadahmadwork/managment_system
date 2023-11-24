document.addEventListener('DOMContentLoaded', function () {
  
  // Check if the current page is the new employee page
  if (window.location.pathname.includes('/leaves/new')) {
    // Display an alert when the new employee page is loaded
    alert('Do you want to create a new leave?');
  }
});

document.addEventListener('DOMContentLoaded', function () {
  var endDateField = document.getElementById('leave_end_date');
  var endDateLabel = document.querySelector('label[for="leave_end_date"]');
  var startDateLabel = document.querySelector('label[for="leave_start_date"]');
  var durationField = document.getElementById('leave_duration'); // Replace with your actual ID

  function hideEndDate() {
    endDateField.style.display = 'none';
    if (endDateLabel) {
      endDateLabel.style.display = 'none';
    }
    // Change the label of start date to 'Select Date'
    startDateLabel.textContent = 'Select Date';
  }

  function showEndDate() {
    endDateField.style.display = 'block'; // or 'inline' based on your layout
    if (endDateLabel) {
      endDateLabel.style.display = 'block';
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
