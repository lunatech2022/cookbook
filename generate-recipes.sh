#!/bin/bash

# Generate recipe HTML pages from markdown files

RECIPES_DIR="/home/openclaw/.openclaw/workspace/recipes"
SITE_DIR="/home/openclaw/.openclaw/workspace/cookbook-v3"

# Function to extract frontmatter value
get_fm() {
    local file="$1"
    local key="$2"
    grep "^${key}:" "$file" | sed "s/^${key}: //" | tr -d '"'
}

# Function to extract section content
get_section() {
    local file="$1"
    local section="$2"
    awk -v section="$section" '
        /^## / { current=$0 }
        current ~ section && /^[-*] / { print $0 }
        current ~ section && /^[0-9]\./ { print $0 }
    ' "$file" | sed 's/^[-*] //'
}

# Generate HTML for a recipe
generate_recipe() {
    local md_file="$1"
    local category="$2"
    local recipe_id="$3"
    
    local title=$(get_fm "$md_file" "title")
    local total_time=$(get_fm "$md_file" "total_time")
    local servings=$(get_fm "$md_file" "servings")
    
    # Extract nutrition
    local calories=$(grep "Calories:" "$md_file" | sed 's/.*Calories: ~\?//' | tr -d ' ')
    local protein=$(grep "Protein:" "$md_file" | sed 's/.*Protein: //')
    local fiber=$(grep "Fiber:" "$md_file" | sed 's/.*Fiber: //')
    local carbs=$(grep "Carbs:" "$md_file" | sed 's/.*Carbs: //' | sed 's/ (.*//')
    
    # Extract sections
    local ingredients=$(get_section "$md_file" "Ingredients")
    local instructions=$(get_section "$md_file" "Instructions")
    local kid_adapt=$(get_section "$md_file" "Kid Adaptation")
    local batch_cook=$(get_section "$md_file" "Batch Cooking")
    
    # Build ingredients HTML
    local ingredients_html=""
    while IFS= read -r line; do
        [ -n "$line" ] && ingredients_html="${ingredients_html}<li>${line}</li>\n"
    done <<< "$ingredients"
    
    # Build instructions HTML
    local instructions_html=""
    while IFS= read -r line; do
        [ -n "$line" ] && instructions_html="${instructions_html}<li>${line}</li>\n"
    done <<< "$instructions"
    
    # Build kid adaptation HTML
    local kid_html=""
    while IFS= read -r line; do
        [ -n "$line" ] && kid_html="${kid_html}<li>${line}</li>\n"
    done <<< "$kid_adapt"
    
    # Build batch cooking HTML
    local batch_html=""
    while IFS= read -r line; do
        [ -n "$line" ] && batch_html="${batch_html}<li>${line}</li>\n"
    done <<< "$batch_cook"
    
    # Capitalize category
    local category_cap="${category^}"
    
    cat > "${SITE_DIR}/${category}/${recipe_id}.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${title} | Family Cookbook</title>
  <link rel="stylesheet" href="../assets/css/style.css?v=4">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
  <header class="site-header">
    <div class="container">
      <a href="../index.html" class="site-title">
        <span class="emoji">🍽️</span>
        <div><h1>Family Cookbook</h1><span class="subtitle">Healthy & Delicious</span></div>
      </a>
      <nav class="main-nav">
        <div class="dropdown">
          <button class="dropbtn">🌅 Breakfast ▼</button>
          <div class="dropdown-content">
            <a href="../breakfast/index.html">All Breakfast</a>
            <a href="../breakfast/quick.html">⚡ Under 15 min</a>
            <a href="../breakfast/medium.html">⏱️ 16-30 min</a>
            <a href="../breakfast/longer.html">🍳 Longer</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">🥗 Lunch ▼</button>
          <div class="dropdown-content">
            <a href="../lunch/index.html">All Lunch</a>
            <a href="../lunch/quick.html">⚡ Under 15 min</a>
            <a href="../lunch/medium.html">⏱️ 16-30 min</a>
            <a href="../lunch/longer.html">🍳 Longer</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">🍽️ Dinner ▼</button>
          <div class="dropdown-content">
            <a href="../dinner/index.html">All Dinner</a>
            <a href="../dinner/quick.html">⚡ Under 15 min</a>
            <a href="../dinner/medium.html">⏱️ 16-30 min</a>
            <a href="../dinner/longer.html">🍳 Longer</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">🥨 Snacks ▼</button>
          <div class="dropdown-content">
            <a href="../snacks/index.html">All Snacks</a>
            <a href="../snacks/quick.html">⚡ Under 15 min</a>
            <a href="../snacks/medium.html">⏱️ 16-30 min</a>
            <a href="../snacks/longer.html">🍳 Longer</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">🥤 Shakes ▼</button>
          <div class="dropdown-content">
            <a href="../shakes/index.html">All Shakes</a>
            <a href="../shakes/quick.html">⚡ Under 15 min</a>
            <a href="../shakes/medium.html">⏱️ 16-30 min</a>
            <a href="../shakes/longer.html">🍳 Longer</a>
          </div>
        </div>
      </nav>
    </div>
  </header>

  <div class="recipe-hero">
    <img src="../assets/images/${recipe_id}.jpg" alt="${title}">
    <div class="recipe-hero-overlay">
      <h1>${title}</h1>
      <div class="recipe-hero-meta">
        <span>⏱️ ${total_time}</span>
        <span>📂 ${category_cap}</span>
        <span>🍽️ ${servings} serving$([ "$servings" != "1" ] && echo "s")</span>
      </div>
    </div>
  </div>

  <main class="recipe-page-body">
    <div class="nutrition-grid">
      <div class="nutrition-item"><div class="value">~${calories}</div><div class="label">Calories</div></div>
      <div class="nutrition-item"><div class="value">${protein}</div><div class="label">Protein</div></div>
      <div class="nutrition-item"><div class="value">${fiber}</div><div class="label">Fiber</div></div>
      <div class="nutrition-item"><div class="value">${carbs}</div><div class="label">Carbs</div></div>
    </div>

    <div class="recipe-body">
      <h2>Ingredients</h2>
      <ul>
        ${ingredients_html}
      </ul>

      <h2>Instructions</h2>
      <ol>
        ${instructions_html}
      </ol>

      <h2>🧒 Kid Adaptation</h2>
      <ul>
        ${kid_html}
      </ul>

      <h2>📦 Batch Cooking</h2>
      <ul>
        ${batch_html}
      </ul>

      <a href="../${category}/index.html" class="back-link">← Back to ${category_cap}</a>
    </div>
  </main>

  <footer class="site-footer">
    <div class="container"><p>Balanced for protein, fiber & flavor 🌱</p></div>
  </footer>
  <script src="../assets/js/tags.js?v=4"></script>
  <script src="../assets/js/search.js?v=4"></script>
  <script src="../assets/js/nav.js?v=4"></script>
</body>
</html>
EOF

    echo "Generated: ${category}/${recipe_id}.html"
}

# Generate all recipes
generate_recipe "$RECIPES_DIR/breakfast/berry-chia-oatmeal.md" "breakfast" "berry-chia-oatmeal"
generate_recipe "$RECIPES_DIR/breakfast/greek-yogurt-parfait.md" "breakfast" "greek-yogurt-parfait"
generate_recipe "$RECIPES_DIR/breakfast/french-toast-sticks.md" "breakfast" "french-toast-sticks"
generate_recipe "$RECIPES_DIR/breakfast/oatmeal-sprinkles.md" "breakfast" "oatmeal-sprinkles"
generate_recipe "$RECIPES_DIR/lunch/chicken-veggie-wrap.md" "lunch" "chicken-veggie-wrap"
generate_recipe "$RECIPES_DIR/dinner/salmon-quinoa-bowl.md" "dinner" "salmon-quinoa-bowl"
generate_recipe "$RECIPES_DIR/dinner/lentil-spinach-curry.md" "dinner" "lentil-spinach-curry"
generate_recipe "$RECIPES_DIR/snacks/edamame-hummus-cups.md" "snacks" "edamame-hummus-cups"
generate_recipe "$RECIPES_DIR/shakes/strawberry-banana-smoothie.md" "shakes" "strawberry-banana-smoothie"

echo "All recipes generated!"
