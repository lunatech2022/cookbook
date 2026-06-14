# Cookbook QA Checklist — AUTOMATED, BLOCKING

**This checklist runs AUTOMATICALLY after every build.** The build will FAIL if any check doesn't pass. No manual running needed.

## Automated Checks (in auto-build.py)

### 1. Content Quality — NO PLACEHOLDERS
- NO recipe page has "Ingredient 1", "Step 1", "Step 2"
- ALL recipes have real ingredients, instructions, kid adaptations, batch cooking
- **Blocking:** Build fails if placeholders found

### 2. Rendering Quality — NO ESCAPE ARTIFACTS
- NO `\n` visible between list items
- NO double numbering ("1. 1. Combine...")
- Instructions use `<ol>` but content has NO leading numbers
- **Blocking:** Build fails if escape artifacts found

### 3. No Stale Labels
- NO "Under 30" anywhere — must be "16-30 min" to match dropdowns
- **Blocking:** Build fails if stale labels found

### 4. Navigation Integrity
- ALL category index pages link to EVERY recipe in that category
- No orphaned recipe pages
- **Blocking:** Build fails if recipes are missing from their category index

### 5. Image Warnings (non-blocking)
- Missing images are WARNED but don't fail the build
- Recipe pages will work, just show broken image icon

## Manual Spot Check (still required before push)
- [ ] Open 2-3 random recipe pages in browser
- [ ] Verify ingredients display as clean bullet list
- [ ] Verify instructions display as clean numbered list
- [ ] Verify no 404s when clicking recipes from category pages

## If Build Fails
1. Read the error message — it tells you exactly what's wrong
2. Fix the issue (usually in recipes/*.md or auto-build.py)
3. Re-run `python3 auto-build.py`
4. Don't push until build passes

## NEVER
- ❌ Push without running auto-build.py first
- ❌ Ignore QA failure messages
- ❌ Tell user "it's done" when QA hasn't run
