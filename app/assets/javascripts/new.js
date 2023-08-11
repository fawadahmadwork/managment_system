// app/assets/javascripts/active_admin.js
document.addEventListener('DOMContentLoaded', function() {
  const testButton = document.getElementById('test-button');

  if (testButton) {
    testButton.addEventListener('click', function() {
      alert('Test button clicked! Your JavaScript is working.');
    });
  }
});


