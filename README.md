# Travel Scrapbook — Supabase Edition

This package keeps your scrapbook UI and connects it to your Supabase project.

## Included
- `index.html` — the full app
- `public/_redirects` — Netlify SPA routing
- `vercel.json` — Vercel routing
- `storage-policies.sql` — storage policies for the `trip-photos` bucket

## Before you deploy
Your Supabase table and RLS policies for `public.trips` were already set up in chat.

Create the `trip-photos` bucket in Supabase Storage and turn **Public bucket** ON.

Then run the SQL in `storage-policies.sql`.

## Deploy on Netlify
1. Unzip this folder.
2. Drag the whole folder to Netlify, or connect it as a static site.
3. Netlify will serve `index.html`.

## Deploy on Vercel
1. Unzip this folder.
2. Import the folder into Vercel as a static project.
3. The included `vercel.json` rewrites `/trip/*`, `/about`, and `/page` to `index.html`.

## Local test
You can open `index.html` directly, but shared routes like `/trip/your-slug` work best when hosted behind Netlify or Vercel.

## Notes
- This version uses your Supabase project URL and publishable key directly in browser code.
- Anyone can read public trips.
- Your current database policy also allows public insert/update, which is fine for a prototype but not ideal for long-term production use.


## Updating your live Netlify site

1. Extract the zip.
2. In Netlify, open your site dashboard.
3. Go to **Deploys** and drag the updated project folder onto the page, or use **Add new deploy**.
4. Wait for the new production deploy to finish, then hard refresh the site.

If you prefer GitHub later, create a repo, upload these files, and connect the repo in Netlify.
