# Cookbook QA Checklist — MANDATORY before every push

Run this checklist before EVERY push to GitHub. No exceptions.

## 1. Content Quality — NO PLACEHOLDERS
- [ ] NO recipe page has "Ingredient 1", "Ingredient 2", "Step 1", "Step 2"
- [ ] ALL recipes have real ingredients, instructions, kid adaptations, batch cooking
- [ ] Quick check: `grep -rl "Ingredient 1" */*.html` returns nothing

## 2. No Stale/Orphaned Files
- [ ] No recipe exists in wrong category folder (e.g., smoothie in breakfast/)
- [ ] All recipe pages in category folders link from index.html
- [ ] Deleted files are actually gone from git

## 3. File Structure
- [ ] search.html exists at root level only
- [ ] All 5 category folders: breakfast/, lunch/, dinner/, snacks/, shakes/
- [ ] Each category has: index.html, quick.html, medium.html, longer.html

## 4. Navigation (All Pages)
- [ ] All 5 dropdowns present on EVERY page type (index, quick, medium, longer, recipe)
- [ ] Shakes dropdown on ALL pages including shakes/*
- [ ] Dropdown links point to correct folders

## 5. Time Filter Labels
- [ ] ALL dropdowns: "⚡ Under 15 min", "⏱️ 16-30 min", "🍳 Longer"
- [ ] NO page has "Under 30" text anywhere
- [ ] Quick check: `grep -rl "Under 30" */*.html` returns nothing

## 6. Cache Busting
- [ ] CSS/JS references use consistent version (e.g., ?v=5)
- [ ] Version bumped when making changes that affect rendering

## 7. JavaScript
- [ ] search.js uses getBasePath() for correct relative paths
- [ ] tags.js has all recipes
- [ ] nav.js handles dropdowns

## 8. Spot Check
- [ ] Open 2-3 random recipe pages — verify real content loads
- [ ] Verify no 404s
