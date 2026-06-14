// Search functionality
(function() {
  let searchContainer = null;
  let searchInput = null;
  let suggestionsBox = null;
  let currentFocus = -1;

  // Get correct path prefix based on current page location
  function getBasePath() {
    const path = window.location.pathname;
    // If we're in a subfolder (like /breakfast/ or /breakfast/recipe.html)
    // we need to go up one level to reach search.html
    if (path.includes('/breakfast/') || path.includes('/lunch/') || 
        path.includes('/dinner/') || path.includes('/snacks/') || 
        path.includes('/shakes/')) {
      return '../';
    }
    return '';
  }

  function initSearch() {
    // Find or create search container
    searchContainer = document.querySelector('.search-container');
    if (!searchContainer) {
      // Insert after site-title in header
      const header = document.querySelector('.site-header .container');
      if (header) {
        const title = header.querySelector('.site-title');
        searchContainer = document.createElement('div');
        searchContainer.className = 'search-container';
        searchContainer.innerHTML = `
          <div class="search-box">
            <input type="text" class="search-input" placeholder="🔍 Search recipes, tags, ingredients..." autocomplete="off">
            <div class="search-suggestions"></div>
          </div>
        `;
        if (title) {
          title.after(searchContainer);
        } else {
          header.insertBefore(searchContainer, header.firstChild);
        }
      }
    }

    searchInput = document.querySelector('.search-input');
    suggestionsBox = document.querySelector('.search-suggestions');

    if (!searchInput) return;

    // Input event for autocomplete
    searchInput.addEventListener('input', function(e) {
      const val = this.value;
      closeAllSuggestions();
      currentFocus = -1;

      if (!val) return;

      const suggestions = getSearchSuggestions(val);
      if (suggestions.length === 0) return;

      suggestionsBox.innerHTML = '';
      suggestionsBox.style.display = 'block';

      suggestions.forEach((suggestion, index) => {
        const div = document.createElement('div');
        div.className = 'suggestion-item';
        if (suggestion.type === 'tag') {
          div.innerHTML = `<span class="suggestion-tag">${suggestion.label}</span>`;
          div.addEventListener('click', function() {
            const basePath = getBasePath();
            window.location.href = `${basePath}search.html?tag=${encodeURIComponent(suggestion.value)}`;
          });
        } else {
          div.innerHTML = `<span class="suggestion-recipe">🍽️ ${suggestion.label}</span>`;
          div.addEventListener('click', function() {
            const recipe = RECIPE_TAGS[suggestion.value];
            const basePath = getBasePath();
            const path = `${basePath}${recipe.category}/${suggestion.value}.html`;
            window.location.href = path;
          });
        }
        suggestionsBox.appendChild(div);
      });
    });

    // Keyboard navigation
    searchInput.addEventListener('keydown', function(e) {
      const items = suggestionsBox.querySelectorAll('.suggestion-item');
      if (e.key === 'ArrowDown') {
        currentFocus++;
        addActive(items);
        e.preventDefault();
      } else if (e.key === 'ArrowUp') {
        currentFocus--;
        addActive(items);
        e.preventDefault();
      } else if (e.key === 'Enter') {
        e.preventDefault();
        if (currentFocus > -1 && items[currentFocus]) {
          items[currentFocus].click();
        } else {
          // Search with text
          const query = searchInput.value.trim();
          if (query) {
            const basePath = getBasePath();
            window.location.href = `${basePath}search.html?q=${encodeURIComponent(query)}`;
          }
        }
      } else if (e.key === 'Escape') {
        closeAllSuggestions();
      }
    });

    // Close suggestions when clicking outside
    document.addEventListener('click', function(e) {
      if (!searchContainer.contains(e.target)) {
        closeAllSuggestions();
      }
    });
  }

  function addActive(items) {
    if (!items) return;
    removeActive(items);
    if (currentFocus >= items.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = items.length - 1;
    items[currentFocus].classList.add('suggestion-active');
  }

  function removeActive(items) {
    items.forEach(item => item.classList.remove('suggestion-active'));
  }

  function closeAllSuggestions() {
    if (suggestionsBox) {
      suggestionsBox.innerHTML = '';
      suggestionsBox.style.display = 'none';
    }
    currentFocus = -1;
  }

  // Add tag badges to recipe cards on the page
  function addTagBadgesToCards() {
    document.querySelectorAll('.recipe-card').forEach(card => {
      const href = card.getAttribute('href');
      if (!href) return;
      
      // Extract recipe ID from href like "berry-chia-oatmeal.html"
      const recipeId = href.replace('.html', '').split('/').pop();
      const tags = getRecipeTags(recipeId);
      
      if (tags.length > 0) {
        const content = card.querySelector('.recipe-card-content');
        if (content && !content.querySelector('.recipe-card-tags')) {
          const tagContainer = document.createElement('div');
          tagContainer.className = 'recipe-card-tags';
          tagContainer.innerHTML = tags.slice(0, 3).map(tag => getTagBadge(tag)).join('');
          content.appendChild(tagContainer);
        }
      }
    });
  }

  // Add tags to recipe page
  function addTagsToRecipePage() {
    const hero = document.querySelector('.recipe-hero-meta');
    if (!hero) return;
    
    // Find recipe ID from page URL or title
    const title = document.querySelector('.recipe-hero-overlay h1');
    if (!title) return;
    
    const recipeName = title.textContent.trim();
    let recipeId = null;
    
    for (const [id, recipe] of Object.entries(RECIPE_TAGS)) {
      if (recipe.name === recipeName) {
        recipeId = id;
        break;
      }
    }
    
    if (!recipeId) return;
    
    const tags = getRecipeTags(recipeId);
    if (tags.length === 0) return;
    
    // Add after nutrition grid
    const nutritionGrid = document.querySelector('.nutrition-grid');
    if (nutritionGrid && !nutritionGrid.nextElementSibling?.classList.contains('recipe-tags-section')) {
      const tagSection = document.createElement('div');
      tagSection.className = 'recipe-tags-section';
      tagSection.innerHTML = `
        <h3>🏷️ Tags</h3>
        <div class="recipe-tags-list">
          ${tags.map(tag => getTagBadge(tag)).join('')}
        </div>
      `;
      nutritionGrid.after(tagSection);
    }
  }

  // Handle tag badge clicks (event delegation)
  document.addEventListener('click', function(e) {
    const badge = e.target.closest('.tag-badge');
    if (!badge || badge.classList.contains('no-click')) return;
    
    const tag = badge.getAttribute('data-tag');
    if (tag) {
      const basePath = getBasePath();
      window.location.href = `${basePath}search.html?tag=${encodeURIComponent(tag)}`;
    }
  });

  // Initialize when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
      initSearch();
      addTagBadgesToCards();
      addTagsToRecipePage();
    });
  } else {
    initSearch();
    addTagBadgesToCards();
    addTagsToRecipePage();
  }
})();
