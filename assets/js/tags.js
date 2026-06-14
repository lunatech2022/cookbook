// Tag data for all recipes
const RECIPE_TAGS = {
  'berry-chia-oatmeal': {
    name: 'Berry Chia Oatmeal',
    category: 'breakfast',
    tags: ['vegetarian', 'high-fiber', 'quick', 'kid-friendly', 'warm', 'under-15'],
    ingredients: ['oats', 'chia seeds', 'berries', 'almond butter', 'milk']
  },
  'greek-yogurt-parfait': {
    name: 'Greek Yogurt Parfait',
    category: 'breakfast',
    tags: ['vegetarian', 'high-protein', 'quick', 'no-cook', 'kid-friendly', 'under-15'],
    ingredients: ['greek yogurt', 'granola', 'berries', 'chia seeds', 'honey']
  },
  'french-toast-sticks': {
    name: 'French Toast Sticks',
    category: 'breakfast',
    tags: ['kid-friendly', 'high-protein', 'fun', 'under-30'],
    ingredients: ['bread', 'eggs', 'milk', 'cinnamon', 'yogurt']
  },
  'oatmeal-sprinkles': {
    name: 'Oatmeal with Superhero Sprinkles',
    category: 'breakfast',
    tags: ['vegetarian', 'kid-friendly', 'quick', 'customizable', 'under-15'],
    ingredients: ['oats', 'chia seeds', 'coconut', 'cocoa', 'sprinkles']
  },
  'chicken-veggie-wrap': {
    name: 'Chicken & Veggie Wrap',
    category: 'lunch',
    tags: ['high-protein', 'lunch-prep', 'portable', 'under-30'],
    ingredients: ['chicken', 'tortilla', 'vegetables', 'hummus', 'cheese']
  },
  'salmon-quinoa-bowl': {
    name: 'Salmon Quinoa Bowl',
    category: 'dinner',
    tags: ['high-protein', 'omega3', 'gluten-free', 'healthy', 'over-30'],
    ingredients: ['salmon', 'quinoa', 'vegetables', 'lemon', 'olive oil']
  },
  'lentil-spinach-curry': {
    name: 'Lentil & Spinach Curry',
    category: 'dinner',
    tags: ['vegetarian', 'vegan', 'high-fiber', 'budget-friendly', 'over-30'],
    ingredients: ['lentils', 'spinach', 'coconut milk', 'tomatoes', 'spices']
  },
  'edamame-hummus-cups': {
    name: 'Edamame Hummus Cups',
    category: 'snacks',
    tags: ['vegetarian', 'vegan', 'snack-prep', 'portable', 'kid-friendly', 'under-15'],
    ingredients: ['edamame', 'chickpeas', 'tahini', 'cucumber', 'carrot']
  },
  'strawberry-banana-smoothie': {
    name: 'Strawberry Banana Smoothie',
    category: 'shakes',
    tags: ['quick', 'high-protein', 'kid-friendly', 'no-cook', 'refreshing', 'under-15'],
    ingredients: ['strawberries', 'banana', 'greek yogurt', 'milk', 'chia seeds']
  }
};

// All unique tags for autocomplete
const ALL_TAGS = [
  'vegetarian', 'vegan', 'high-protein', 'high-fiber', 'quick', 'kid-friendly',
  'no-cook', 'gluten-free', 'budget-friendly', 'lunch-prep', 'snack-prep',
  'portable', 'customizable', 'fun', 'warm', 'refreshing', 'healthy', 'omega3',
  'under-15', 'under-30', 'over-30'
];

// Tag display names (friendly labels)
const TAG_LABELS = {
  'vegetarian': '🌿 Vegetarian',
  'vegan': '🌱 Vegan',
  'high-protein': '🥩 High Protein',
  'high-fiber': '🌾 High Fiber',
  'quick': '⚡ Quick',
  'kid-friendly': '🧒 Kid Friendly',
  'no-cook': '🧊 No Cook',
  'gluten-free': '🌾 Gluten Free',
  'budget-friendly': '💰 Budget Friendly',
  'lunch-prep': '🍱 Lunch Prep',
  'snack-prep': '🥨 Snack Prep',
  'portable': '🎒 Portable',
  'customizable': '✨ Customizable',
  'fun': '🎉 Fun',
  'warm': '☀️ Warm',
  'refreshing': '❄️ Refreshing',
  'healthy': '💚 Healthy',
  'omega3': '🐟 Omega-3',
  'under-15': '⚡ Under 15 min',
  'under-30': '⏱️ Under 30 min',
  'over-30': '🍳 30+ min'
};

// Get tag badge HTML
function getTagBadge(tag, clickable = true) {
  const label = TAG_LABELS[tag] || tag;
  if (clickable) {
    return `<span class="tag-badge" data-tag="${tag}">${label}</span>`;
  }
  return `<span class="tag-badge no-click">${label}</span>`;
}

// Get all tags for a recipe
function getRecipeTags(recipeId) {
  const recipe = RECIPE_TAGS[recipeId];
  return recipe ? recipe.tags : [];
}

// Search recipes by query
function searchRecipes(query) {
  query = query.toLowerCase().trim();
  if (!query) return [];
  
  const results = [];
  
  for (const [id, recipe] of Object.entries(RECIPE_TAGS)) {
    let score = 0;
    
    // Name match (highest priority)
    if (recipe.name.toLowerCase().includes(query)) score += 10;
    
    // Tag match
    recipe.tags.forEach(tag => {
      if (tag.toLowerCase().includes(query)) score += 5;
      const label = (TAG_LABELS[tag] || '').toLowerCase();
      if (label.includes(query)) score += 5;
    });
    
    // Ingredient match
    recipe.ingredients.forEach(ing => {
      if (ing.toLowerCase().includes(query)) score += 3;
    });
    
    // Category match
    if (recipe.category.toLowerCase().includes(query)) score += 2;
    
    if (score > 0) {
      results.push({ id, ...recipe, score });
    }
  }
  
  return results.sort((a, b) => b.score - a.score);
}

// Get suggestions for autocomplete
function getSearchSuggestions(query) {
  query = query.toLowerCase().trim();
  if (!query) return [];
  
  const suggestions = [];
  const seen = new Set();
  
  // Tag suggestions
  ALL_TAGS.forEach(tag => {
    if (tag.toLowerCase().includes(query)) {
      suggestions.push({ type: 'tag', value: tag, label: TAG_LABELS[tag] || tag });
      seen.add(tag);
    }
  });
  
  // Recipe name suggestions
  Object.entries(RECIPE_TAGS).forEach(([id, recipe]) => {
    if (recipe.name.toLowerCase().includes(query) && !seen.has(recipe.name)) {
      suggestions.push({ type: 'recipe', value: id, label: recipe.name });
      seen.add(recipe.name);
    }
  });
  
  return suggestions.slice(0, 8); // Max 8 suggestions
}
