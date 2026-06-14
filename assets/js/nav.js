// Dropdown navigation - click to open
document.addEventListener('DOMContentLoaded', function() {
  const dropdowns = document.querySelectorAll('.dropdown');
  
  dropdowns.forEach(dropdown => {
    const btn = dropdown.querySelector('.dropbtn');
    const content = dropdown.querySelector('.dropdown-content');
    
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
      
      // Close all other dropdowns
      dropdowns.forEach(d => {
        if (d !== dropdown) {
          d.querySelector('.dropdown-content').classList.remove('show');
          d.querySelector('.dropbtn').classList.remove('active');
        }
      });
      
      // Toggle current
      content.classList.toggle('show');
      btn.classList.toggle('active');
    });
  });
  
  // Close dropdowns when clicking outside
  document.addEventListener('click', function() {
    dropdowns.forEach(dropdown => {
      dropdown.querySelector('.dropdown-content').classList.remove('show');
      dropdown.querySelector('.dropbtn').classList.remove('active');
    });
  });
  
  // Close on escape key
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
      dropdowns.forEach(dropdown => {
        dropdown.querySelector('.dropdown-content').classList.remove('show');
        dropdown.querySelector('.dropbtn').classList.remove('active');
      });
    }
  });
});
