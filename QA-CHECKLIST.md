# Cookbook QA Checklist

Run this checklist before every push to GitHub.

## Navigation (All Pages)
- [ ] All 5 dropdowns present: Breakfast, Lunch, Dinner, Snacks, Shakes
- [ ] Each dropdown has correct links (not pointing to wrong category)
- [ ] Shakes dropdown exists on ALL pages including shakes/*
- [ ] CSS/JS loaded with cache-busting query param (?v=X)
- [ ] Search bar visible and functional

## Homepage
- [ ] Title says "Family Cookbook" (not "Saini Family")
- [ ] 9 recipe cards visible
- [ ] Smoothie is in Shakes section (not Breakfast)
- [ ] All images load
- [ ] Tag badges visible on recipe cards

## Search Feature
- [ ] Search bar shows in header
- [ ] Typing shows autocomplete suggestions
- [ ] Tag suggestions show with 🏷️ icon
- [ ] Recipe suggestions show with 🍽️ icon
- [ ] Clicking suggestion navigates correctly
- [ ] Search results page works with ?q= and ?tag= params
- [ ] Tag badges are clickable and filter recipes

## Category Pages (index.html)
- [ ] Recipes actually listed (not empty grid)
- [ ] Correct number of recipes showing
- [ ] Tag badges visible on cards

## Time Filters
Rule: Quick = under 15 min | Medium = 15-29 min | Longer = 30+ min
- [ ] breakfast/quick: Greek Yogurt (5), Berry Chia (10), Oatmeal Sprinkles (10)
- [ ] breakfast/medium: French Toast (15)
- [ ] lunch/medium: Chicken Wrap (15)
- [ ] dinner/longer: Salmon (30), Lentil Curry (35)
- [ ] snacks/quick: Edamame (5)
- [ ] shakes/quick: Smoothie (5)
- [ ] No duplicates across quick/medium/longer

## Recipe Pages
- [ ] Hero image shows
- [ ] Category tag correct (📂 Breakfast/Lunch/Dinner/Snacks/Shakes)
- [ ] Back link points to correct category
- [ ] Nav has all 5 dropdowns
- [ ] Nutrition grid shows
- [ ] Tags section visible below nutrition grid
- [ ] Tag badges clickable

## Spot Check (Pick 2-3 Random Pages)
- [ ] No 404s on any clicked link
- [ ] Dropdown hover/click works
- [ ] Mobile layout looks OK
- [ ] Search autocomplete works
