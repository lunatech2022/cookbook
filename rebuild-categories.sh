#!/bin/bash

# Rebuild all category pages with recipes and proper nav

# Nav snippet with Shakes
NAV='      <nav class="main-nav">
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
        <div class="dropdown">
          <button class="dropbtn">🥤 Shakes ▼</button>
          <div class="dropdown-content">
            <a href="../shakes/index.html">All Shakes</a>
            <a href="../shakes/quick.html">⚡ Under 15 min</a>
            <a href="../shakes/medium.html">⏱️ Under 30 min</a>
            <a href="../shakes/longer.html">🍳 Longer</a>
          </div>
        </div>
      </nav>'

# Breakfast recipes
BREAKFAST_RECIPES='<a href="berry-chia-oatmeal.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/berry-chia-oatmeal.jpg" alt="Berry Chia Oatmeal">
              <span class="recipe-card-badge">Breakfast</span>
              <span class="recipe-card-time">⏱️ 10 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(12 reviews)</span></div>
              <h4>Berry Chia Oatmeal</h4>
              <p>Warm, fiber-packed oatmeal with fresh berries and nut butter</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">14g</span> protein</div><div class="stat">🌾 <span class="stat-value">12g</span> fiber</div></div>
            </div>
          </a>
          <a href="greek-yogurt-parfait.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/greek-yogurt-parfait.jpg" alt="Greek Yogurt Parfait">
              <span class="recipe-card-badge">Breakfast</span>
              <span class="recipe-card-time">⏱️ 5 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(18 reviews)</span></div>
              <h4>Greek Yogurt Parfait</h4>
              <p>Creamy, high-protein parfait with chia and berries</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">20g</span> protein</div><div class="stat">🌾 <span class="stat-value">12g</span> fiber</div></div>
            </div>
          </a>
          <a href="french-toast-sticks.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/french-toast-sticks.jpg" alt="French Toast Sticks">
              <span class="recipe-card-badge">Breakfast</span>
              <span class="recipe-card-time">⏱️ 15 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★☆</span><span class="rating-count">(8 reviews)</span></div>
              <h4>French Toast Sticks</h4>
              <p>Kid-friendly dipping breakfast with yogurt dip</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">20g</span> protein</div><div class="stat">🌾 <span class="stat-value">4g</span> fiber</div></div>
            </div>
          </a>
          <a href="oatmeal-sprinkles.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/oatmeal-sprinkles.jpg" alt="Oatmeal with Superhero Sprinkles">
              <span class="recipe-card-badge">Breakfast</span>
              <span class="recipe-card-time">⏱️ 10 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(22 reviews)</span></div>
              <h4>Oatmeal with "Superhero Sprinkles"</h4>
              <p>Kids love adding their own toppings</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">15g</span> protein</div><div class="stat">🌾 <span class="stat-value">8g</span> fiber</div></div>
            </div>
          </a>'

# Quick breakfast (under 15 min)
BREAKFAST_QUICK='<a href="greek-yogurt-parfait.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/greek-yogurt-parfait.jpg" alt="Greek Yogurt Parfait">
              <span class="recipe-card-badge">Breakfast</span>
              <span class="recipe-card-time">⏱️ 5 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(18 reviews)</span></div>
              <h4>Greek Yogurt Parfait</h4>
              <p>Creamy, high-protein parfait with chia and berries</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">20g</span> protein</div><div class="stat">🌾 <span class="stat-value">12g</span> fiber</div></div>
            </div>
          </a>
          <a href="french-toast-sticks.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/french-toast-sticks.jpg" alt="French Toast Sticks">
              <span class="recipe-card-badge">Breakfast</span>
              <span class="recipe-card-time">⏱️ 15 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★☆</span><span class="rating-count">(8 reviews)</span></div>
              <h4>French Toast Sticks</h4>
              <p>Kid-friendly dipping breakfast with yogurt dip</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">20g</span> protein</div><div class="stat">🌾 <span class="stat-value">4g</span> fiber</div></div>
            </div>
          </a>'

# Function to generate category page
generate_page() {
  local folder=$1
  local title=$2
  local subtitle=$3
  local recipes=$4
  local page=$5
  local header_title=$6
  
  cat > "$folder/$page.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$header_title | Family Cookbook</title>
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
$NAV
    </div>
  </header>

  <main class="main-content">
    <div class="category-header">
      <h2>$title</h2>
      <p>$subtitle</p>
    </div>

    <div class="quick-filters">
      <div class="time-filters">
        <a href="quick.html" class="time-filter">⚡ Under 15 min</a>
        <a href="medium.html" class="time-filter">⏱️ Under 30 min</a>
        <a href="longer.html" class="time-filter">🍳 Longer</a>
      </div>
    </div>

    <div class="container">
      <div class="recipe-grid">
        $recipes
      </div>
    </div>
  </main>

  <footer class="site-footer">
    <div class="container"><p>Balanced for protein, fiber & flavor 🌱</p></div>
  </footer>
<script src="../assets/js/nav.js"></script>
</body>
</html>
EOF
}

# Breakfast pages
generate_page "breakfast" "🌅 Breakfast" "Start the day with protein and fiber" "$BREAKFAST_RECIPES" "index" "All Breakfast"
generate_page "breakfast" "⚡ Quick Breakfast" "Under 15 minutes" "$BREAKFAST_QUICK" "quick" "Quick Breakfast"
generate_page "breakfast" "⏱️ Breakfast Under 30" "Weekday-friendly" "$BREAKFAST_RECIPES" "medium" "Breakfast Under 30"
generate_page "breakfast" "🍳 Weekend Breakfast" "Take your time" "" "longer" "Weekend Breakfast"

# Lunch recipes
LUNCH_RECIPES='<a href="chicken-veggie-wrap.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/chicken-veggie-wrap.jpg" alt="Chicken & Veggie Wrap">
              <span class="recipe-card-badge">Lunch</span>
              <span class="recipe-card-time">⏱️ 15 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(10 reviews)</span></div>
              <h4>Chicken & Veggie Wrap</h4>
              <p>Colorful, protein-packed wrap that is easy to customize</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">35g</span> protein</div><div class="stat">🌾 <span class="stat-value">8g</span> fiber</div></div>
            </div>
          </a>'

generate_page "lunch" "🥗 Lunch" "Midday meals to keep energy steady" "$LUNCH_RECIPES" "index" "All Lunch"
generate_page "lunch" "⚡ Quick Lunch" "Under 15 minutes" "$LUNCH_RECIPES" "quick" "Quick Lunch"
generate_page "lunch" "⏱️ Lunch Under 30" "Weekday-friendly" "$LUNCH_RECIPES" "medium" "Lunch Under 30"
generate_page "lunch" "🍳 Weekend Lunch" "Take your time" "" "longer" "Weekend Lunch"

# Dinner recipes
DINNER_RECIPES='<a href="salmon-quinoa-bowl.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/salmon-quinoa-bowl.jpg" alt="Salmon Quinoa Bowl">
              <span class="recipe-card-badge">Dinner</span>
              <span class="recipe-card-time">⏱️ 30 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(20 reviews)</span></div>
              <h4>Salmon Quinoa Bowl</h4>
              <p>Protein powerhouse with omega-3s and fiber</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">38g</span> protein</div><div class="stat">🌾 <span class="stat-value">8g</span> fiber</div></div>
            </div>
          </a>
          <a href="lentil-spinach-curry.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/lentil-spinach-curry.jpg" alt="Lentil & Spinach Curry">
              <span class="recipe-card-badge">Dinner</span>
              <span class="recipe-card-time">⏱️ 35 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★☆</span><span class="rating-count">(14 reviews)</span></div>
              <h4>Lentil & Spinach Curry</h4>
              <p>Hearty plant-based dinner</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">18g</span> protein</div><div class="stat">🌾 <span class="stat-value">15g</span> fiber</div></div>
            </div>
          </a>'

DINNER_QUICK=''
DINNER_MEDIUM='<a href="salmon-quinoa-bowl.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/salmon-quinoa-bowl.jpg" alt="Salmon Quinoa Bowl">
              <span class="recipe-card-badge">Dinner</span>
              <span class="recipe-card-time">⏱️ 30 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(20 reviews)</span></div>
              <h4>Salmon Quinoa Bowl</h4>
              <p>Protein powerhouse with omega-3s and fiber</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">38g</span> protein</div><div class="stat">🌾 <span class="stat-value">8g</span> fiber</div></div>
            </div>
          </a>'

generate_page "dinner" "🍽️ Dinner" "Family dinners everyone will enjoy" "$DINNER_RECIPES" "index" "All Dinner"
generate_page "dinner" "⚡ Quick Dinner" "Under 15 minutes" "$DINNER_QUICK" "quick" "Quick Dinner"
generate_page "dinner" "⏱️ Dinner Under 30" "Weeknight-friendly" "$DINNER_MEDIUM" "medium" "Dinner Under 30"
generate_page "dinner" "🍳 Weekend Dinner" "Take your time" "$DINNER_RECIPES" "longer" "Weekend Dinner"

# Snacks recipes
SNACKS_RECIPES='<a href="edamame-hummus-cups.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/edamame-hummus-cups.jpg" alt="Edamame Hummus Cups">
              <span class="recipe-card-badge">Snack</span>
              <span class="recipe-card-time">⏱️ 5 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(16 reviews)</span></div>
              <h4>Edamame Hummus Cups</h4>
              <p>Crunchy, savory snack cups with protein and fiber</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">10g</span> protein</div><div class="stat">🌾 <span class="stat-value">6g</span> fiber</div></div>
            </div>
          </a>'

generate_page "snacks" "🥨 Snacks" "Healthy bites between meals" "$SNACKS_RECIPES" "index" "All Snacks"
generate_page "snacks" "⚡ Quick Snacks" "Under 15 minutes" "$SNACKS_RECIPES" "quick" "Quick Snacks"
generate_page "snacks" "⏱️ Snacks Under 30" "Easy to make" "$SNACKS_RECIPES" "medium" "Snacks Under 30"
generate_page "snacks" "🍳 Weekend Snacks" "Take your time" "" "longer" "Weekend Snacks"

# Shakes recipes
SHAKES_RECIPES='<a href="strawberry-banana-smoothie.html" class="recipe-card">
            <div class="recipe-card-image">
              <img src="../assets/images/strawberry-banana-smoothie.jpg" alt="Strawberry Banana Smoothie">
              <span class="recipe-card-badge">Shake</span>
              <span class="recipe-card-time">⏱️ 5 min</span>
            </div>
            <div class="recipe-card-content">
              <div class="recipe-card-rating"><span class="stars">★★★★★</span><span class="rating-count">(15 reviews)</span></div>
              <h4>Strawberry Banana Smoothie</h4>
              <p>Tastes like a milkshake but packs protein and fiber</p>
              <div class="recipe-stats"><div class="stat">🥩 <span class="stat-value">18g</span> protein</div><div class="stat">🌾 <span class="stat-value">6g</span> fiber</div></div>
            </div>
          </a>'

generate_page "shakes" "🥤 Shakes" "Protein-packed smoothies and specialty shakes" "$SHAKES_RECIPES" "index" "All Shakes"
generate_page "shakes" "⚡ Quick Shakes" "Under 15 minutes" "$SHAKES_RECIPES" "quick" "Quick Shakes"
generate_page "shakes" "⏱️ Shakes Under 30" "Easy to blend" "$SHAKES_RECIPES" "medium" "Shakes Under 30"
generate_page "shakes" "🍳 Weekend Shakes" "Take your time" "" "longer" "Weekend Shakes"

echo "All category pages rebuilt!"
