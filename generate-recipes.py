#!/usr/bin/env python3
"""Generate recipe HTML pages from markdown files."""

import os
import re
import glob

RECIPES_DIR = "/home/openclaw/.openclaw/workspace/recipes"
SITE_DIR = "/home/openclaw/.openclaw/workspace/cookbook-v3"

NAV_HTML = """<nav class="main-nav">
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
      </nav>"""

def parse_frontmatter(content):
    """Extract frontmatter values."""
    data = {}
    for line in content.split('\n'):
        if ':' in line and not line.startswith('#'):
            key, val = line.split(':', 1)
            data[key.strip()] = val.strip().strip('"')
    return data

def extract_section(content, section_name):
    """Extract bullet/numbered items from a markdown section."""
    lines = content.split('\n')
    in_section = False
    items = []
    for line in lines:
        # Match headers that contain the section name (handles emoji prefixes)
        if line.startswith('## ') and section_name in line:
            in_section = True
            continue
        if in_section:
            if line.startswith('## '):
                break
            # Match bullet points or numbered items
            m = re.match(r'^(?:[-*]|\d+\.)\s+(.+)$', line.strip())
            if m:
                items.append(m.group(1))
    return items

def generate_recipe(md_path, category, recipe_id):
    with open(md_path, 'r') as f:
        content = f.read()
    
    fm = parse_frontmatter(content)
    title = fm.get('title', recipe_id.replace('-', ' ').title())
    total_time = fm.get('total_time', '')
    servings = fm.get('servings', '1')
    
    # Nutrition
    nutrition = {}
    for line in content.split('\n'):
        m = re.match(r'^-\s+(?:Calories|Protein|Fiber|Carbs):\s+~?(.+)$', line.strip())
        if m:
            key = line.split(':')[0].strip('- ')
            nutrition[key.lower()] = m.group(1).strip()
    
    calories = nutrition.get('calories', '')
    protein = nutrition.get('protein', '')
    fiber = nutrition.get('fiber', '')
    carbs = nutrition.get('carbs', '')
    
    # Extract sections
    ingredients = extract_section(content, 'Ingredients')
    instructions = extract_section(content, 'Instructions')
    kid_adapt = extract_section(content, 'Kid Adaptation')
    batch_cook = extract_section(content, 'Batch Cooking')
    
    # Build HTML
    ingredients_html = '\n'.join(f'<li>{item}</li>' for item in ingredients)
    instructions_html = '\n'.join(f'<li>{item}</li>' for item in instructions)
    kid_html = '\n'.join(f'<li>{item}</li>' for item in kid_adapt)
    batch_html = '\n'.join(f'<li>{item}</li>' for item in batch_cook)
    
    category_cap = category.capitalize()
    s_plural = 's' if servings != '1' else ''
    
    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{title} | Family Cookbook</title>
  <link rel="stylesheet" href="../assets/css/style.css?v=6">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>
  <header class="site-header">
    <div class="container">
      <a href="../index.html" class="site-title">
        <span class="emoji">🍽️</span>
        <div><h1>Family Cookbook</h1><span class="subtitle">Healthy & Delicious</span></div>
      </a>
      {NAV_HTML}
    </div>
  </header>

  <div class="recipe-hero">
    <img src="../assets/images/{recipe_id}.jpg" alt="{title}">
    <div class="recipe-hero-overlay">
      <h1>{title}</h1>
      <div class="recipe-hero-meta">
        <span>⏱️ {total_time}</span>
        <span>📂 {category_cap}</span>
        <span>🍽️ {servings} serving{s_plural}</span>
      </div>
    </div>
  </div>

  <main class="recipe-page-body">
    <div class="nutrition-grid">
      <div class="nutrition-item"><div class="value">~{calories}</div><div class="label">Calories</div></div>
      <div class="nutrition-item"><div class="value">{protein}</div><div class="label">Protein</div></div>
      <div class="nutrition-item"><div class="value">{fiber}</div><div class="label">Fiber</div></div>
      <div class="nutrition-item"><div class="value">{carbs}</div><div class="label">Carbs</div></div>
    </div>

    <div class="recipe-body">
      <h2>Ingredients</h2>
      <ul>
        {ingredients_html}
      </ul>

      <h2>Instructions</h2>
      <ol>
        {instructions_html}
      </ol>

      <h2>🧒 Kid Adaptation</h2>
      <ul>
        {kid_html}
      </ul>

      <h2>📦 Batch Cooking</h2>
      <ul>
        {batch_html}
      </ul>

      <a href="../{category}/index.html" class="back-link">← Back to {category_cap}</a>
    </div>
  </main>

  <footer class="site-footer">
    <div class="container"><p>Balanced for protein, fiber & flavor 🌱</p></div>
  </footer>
  <script src="../assets/js/tags.js?v=6"></script>
  <script src="../assets/js/search.js?v=6"></script>
  <script src="../assets/js/nav.js?v=6"></script>
</body>
</html>"""
    
    out_path = os.path.join(SITE_DIR, category, f"{recipe_id}.html")
    with open(out_path, 'w') as f:
        f.write(html)
    print(f"Generated: {category}/{recipe_id}.html")

# Recipe mapping
recipes = [
    ("breakfast/berry-chia-oatmeal.md", "breakfast", "berry-chia-oatmeal"),
    ("breakfast/greek-yogurt-parfait.md", "breakfast", "greek-yogurt-parfait"),
    ("breakfast/french-toast-sticks.md", "breakfast", "french-toast-sticks"),
    ("breakfast/oatmeal-sprinkles.md", "breakfast", "oatmeal-sprinkles"),
    ("lunch/chicken-veggie-wrap.md", "lunch", "chicken-veggie-wrap"),
    ("dinner/salmon-quinoa-bowl.md", "dinner", "salmon-quinoa-bowl"),
    ("dinner/lentil-spinach-curry.md", "dinner", "lentil-spinach-curry"),
    ("snacks/edamame-hummus-cups.md", "snacks", "edamame-hummus-cups"),
    ("snacks/guacamole.md", "snacks", "guacamole"),
    ("shakes/strawberry-banana-smoothie.md", "shakes", "strawberry-banana-smoothie"),
]

for md_file, category, recipe_id in recipes:
    md_path = os.path.join(RECIPES_DIR, md_file)
    if os.path.exists(md_path):
        generate_recipe(md_path, category, recipe_id)
    else:
        print(f"WARNING: Missing {md_path}")

print("All recipes generated!")
