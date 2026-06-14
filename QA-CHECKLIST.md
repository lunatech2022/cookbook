# Cookbook QA Checklist — MANDATORY before every push

Run this checklist before EVERY push to GitHub. No exceptions.

## 1. Content Quality — NO PLACEHOLDERS
- [ ] NO recipe page has "Ingredient 1", "Ingredient 2", "Step 1", "Step 2"
- [ ] ALL recipes have real ingredients, instructions, kid adaptations, batch cooking
- [ ] Quick check: `grep -rl "Ingredient 1" */*.html` returns nothing

## 2. Rendering Quality — NO ESCAPE ARTIFACTS
- [ ] NO `\n` visible between list items
- [ ] NO double numbering ("1. 1. Combine...")
- [ ] Instructions use `<ol>` but content has NO leading numbers
- [ ] Quick check: `grep -rl "\\n" */*.html` returns nothing

## 3. No Stale/Orphaned Files
- [ ] No recipe exists in wrong category folder
- [ ] All recipe pages in category folders link from index.html
- [ ] Deleted files are actually gone from git

## 4. File Structure
- [ ] search.html at root only
- [ ] 5 category folders with index, quick, medium, longer

## 5. Navigation (All Pages)
- [ ] All 5 dropdowns present on EVERY page type
- [ ] Shakes dropdown on ALL pages including shakes/*
- [ ] Dropdown links point to correct folders

## 6. Time Filter Labels
- [ ] ALL dropdowns: "⚡ Under 15 min", "⏱️ 16-30 min", "🍳 Longer"
- [ ] NO "Under 30" anywhere: `grep -rl "Under 30" */*.html` returns nothing

## 7. Cache Busting
- [ ] CSS/JS references use consistent version
- [ ] Version bumped when making changes

## 8. Spot Check — VISUAL VERIFICATION
- [ ] Open 2-3 random recipe pages in browser
- [ ] Verify ingredients display as clean bullet list
- [ ] Verify instructions display as clean numbered list (no artifacts)
- [ ] Verify no 404s
