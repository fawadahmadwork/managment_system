document.addEventListener('DOMContentLoaded', function () {
  // Check if the current page is the new employee page
  if (window.location.pathname.includes('/employees/new')) {
    // Display an alert when the new employee page is loaded
    alert('Do you want to create a new employee?');
  }
});
