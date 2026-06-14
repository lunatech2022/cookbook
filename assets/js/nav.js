// Dropdown navigation - click OR hover to open
document.addEventListener('DOMContentLoaded', function() {
  const dropdowns = document.querySelectorAll('.dropdown');
  let hoverTimeouts = new Map();
  
  dropdowns.forEach(dropdown => {
    const btn = dropdown.querySelector('.dropbtn');
    const content = dropdown.querySelector('.dropdown-content');
    const dropdownId = Math.random().toString(36).substr(2, 9);
    dropdown.dataset.id = dropdownId;
    
    // Click to toggle
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
      
      const isOpen = content.classList.contains('show');
      
      // Close ALL dropdowns first
      dropdowns.forEach(d => {
        d.querySelector('.dropdown-content').classList.remove('show');
        d.querySelector('.dropbtn').classList.remove('active');
        const id = d.dataset.id;
        if (hoverTimeouts.has(id)) {
          clearTimeout(hoverTimeouts.get(id));
          hoverTimeouts.delete(id);
        }
      });
      
      // Toggle current if it wasn't open
      if (!isOpen) {
        content.classList.add('show');
        btn.classList.add('active');
      }
    });
    
    // Hover support with delay - only for this specific dropdown
    dropdown.addEventListener('mouseenter', function() {
      // Clear any close timeout for this dropdown
      if (hoverTimeouts.has(dropdownId)) {
        clearTimeout(hoverTimeouts.get(dropdownId));
        hoverTimeouts.delete(dropdownId);
      }
      
      // Open this dropdown
      content.classList.add('show');
      btn.classList.add('active');
    });
    
    dropdown.addEventListener('mouseleave', function(e) {
      // Check if moving to another dropdown
      const related = e.relatedTarget;
      if (related && related.closest('.dropdown')) {
        // Moving to another dropdown, close this one
        content.classList.remove('show');
        btn.classList.remove('active');
        return;
      }
      
      // Delay before closing
      const timeout = setTimeout(function() {
        content.classList.remove('show');
        btn.classList.remove('active');
      }, 400);
      hoverTimeouts.set(dropdownId, timeout);
    });
  });
  
  // Close dropdowns when clicking outside
  document.addEventListener('click', function(e) {
    if (!e.target.closest('.dropdown')) {
      dropdowns.forEach(dropdown => {
        dropdown.querySelector('.dropdown-content').classList.remove('show');
        dropdown.querySelector('.dropbtn').classList.remove('active');
      });
    }
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
