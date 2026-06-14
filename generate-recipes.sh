#!/bin/bash

# Recipe data: slug|category|title|time|calories|protein|fiber|carbs|image|description
recipes=(
  "berry-chia-oatmeal|Breakfast|Berry Chia Oatmeal|10 min|~380|14g|12g|55g|berry-chia-oatmeal.jpg|Warm, fiber-packed oatmeal with fresh berries and nut butter"
  "greek-yogurt-parfait|Breakfast|Greek Yogurt Parfait|5 min|~320|20g|12g|28g|greek-yogurt-parfait.jpg|Creamy, high-protein parfait with chia and berries"
  "french-toast-sticks|Breakfast|French Toast Sticks|15 min|~350|20g|4g|40g|french-toast-sticks.jpg|Kid-friendly dipping breakfast with yogurt dip"
  "strawberry-banana-smoothie|Breakfast|Strawberry Banana Smoothie|5 min|~280|18g|6g|35g|strawberry-banana-smoothie.jpg|Refreshing smoothie that packs protein and fiber"
  "oatmeal-sprinkles|Breakfast|Oatmeal with Superhero Sprinkles|10 min|~300|15g|8g|45g|oatmeal-sprinkles.jpg|Kids love adding their own superfood toppings"
  "chicken-veggie-wrap|Lunch|Chicken & Veggie Wrap|15 min|~450|35g|8g|35g|chicken-veggie-wrap.jpg|Colorful, protein-packed wrap"
  "salmon-quinoa-bowl|Dinner|Salmon Quinoa Bowl|30 min|~520|38g|8g|35g|salmon-quinoa-bowl.jpg|Protein powerhouse with omega-3s"
  "lentil-spinach-curry|Dinner|Lentil & Spinach Curry|35 min|~420|18g|15g|50g|lentil-spinach-curry.jpg|Hearty plant-based dinner"
  "edamame-hummus-cups|Snack|Edamame Hummus Cups|5 min|~200|10g|6g|18g|edamame-hummus-cups.jpg|Crunchy, savory snack cups"
)

for recipe in "${recipes[@]}"; do
  IFS='|' read -r slug category title time calories protein fiber carbs image description <<< "$recipe"
  
  folder=$(echo "$category" | tr '[:upper:]' '[:lower:]')
  
  cat > "$folder/$slug.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$title | Family Cookbook</title>
  <link rel="stylesheet" href="../assets/css/style.css">
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
            <a href="../breakfast/medium.html">⏱️ Under 30 min</a>
            <a href="../breakfast/longer.html">🍳 Longer</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">🥗 Lunch ▼</button>
          <div class="dropdown-content">
            <a href="../lunch/index.html">All Lunch</a>
            <a href="../lunch/quick.html">⚡ Under 15 min</a>
            <a href="../lunch/medium.html">⏱️ Under 30 min</a>
            <a href="../lunch/longer.html">🍳 Longer</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">🍽️ Dinner ▼</button>
          <div class="dropdown-content">
            <a href="../dinner/index.html">All Dinner</a>
            <a href="../dinner/quick.html">⚡ Under 15 min</a>
            <a href="../dinner/medium.html">⏱️ Under 30 min</a>
            <a href="../dinner/longer.html">🍳 Longer</a>
          </div>
        </div>
        <div class="dropdown">
          <button class="dropbtn">🥨 Snacks ▼</button>
          <div class="dropdown-content">
            <a href="../snacks/index.html">All Snacks</a>
            <a href="../snacks/quick.html">⚡ Under 15 min</a>
            <a href="../snacks/medium.html">⏱️ Under 30 min</a>
            <a href="../snacks/longer.html">🍳 Longer</a>
          </div>
        </div>
      </nav>
    </div>
  </header>

  <div class="recipe-hero">
    <img src="../assets/images/$image" alt="$title">
    <div class="recipe-hero-overlay">
      <h1>$title</h1>
      <div class="recipe-hero-meta">
        <span>⏱️ $time</span>
        <span>📂 $category</span>
      </div>
    </div>
  </div>

  <main class="recipe-page-body">
    <p class="recipe-description">$description</p>

    <div class="nutrition-grid">
      <div class="nutrition-item"><div class="value">$calories</div><div class="label">Calories</div></div>
      <div class="nutrition-item"><div class="value">$protein</div><div class="label">Protein</div></div>
      <div class="nutrition-item"><div class="value">$fiber</div><div class="label">Fiber</div></div>
      <div class="nutrition-item"><div class="value">$carbs</div><div class="label">Carbs</div></div>
    </div>

    <div class="recipe-body">
      <h2>Ingredients</h2>
      <ul>
        <li>Ingredient 1</li>
        <li>Ingredient 2</li>
        <li>Ingredient 3</li>
      </ul>

      <h2>Instructions</h2>
      <ol>
        <li>Step 1</li>
        <li>Step 2</li>
        <li>Step 3</li>
      </ol>

      <h2>🧒 Kid Adaptation</h2>
      <ul>
        <li>Make it fun for kids</li>
        <li>Let them help with prep</li>
      </ul>

      <h2>📦 Batch Cooking</h2>
      <ul>
        <li>Make ahead tips</li>
        <li>Storage instructions</li>
      </ul>

      <a href="../index.html#$folder" class="back-link">← Back to $category</a>
    </div>
  </main>

  <footer class="site-footer">
    <div class="container"><p>Balanced for protein, fiber & flavor 🌱</p></div>
  </footer>
</body>
</html>
EOF

done

echo "Generated recipe pages"
