# ✈️ Travel Scrapbook

A beautiful visual travel diary that lets you document adventures with photos, stories, stickers, and shareable pages — all powered by [Supabase](https://supabase.com) for storage and a real-time backend.

🌐 **Live app:** [https://travel-scrapbook-nihar2082.vercel.app](https://travel-scrapbook-nihar2082.vercel.app)

---

## Features

| Feature | Description |
|---|---|
| 📸 **Drag & Drop Photos** | Drop photos onto a page — they appear as tilted polaroids in a collage |
| ✍️ **Tell Your Story** | Write about your adventure in handwritten-style text on a paper canvas |
| ✨ **Stickers & Emojis** | Decorate with 30 travel-themed stickers (maps, food, landmarks, and more) |
| 🔗 **Share Publicly** | One-click share link anyone can open — no login required |
| ⬇️ **Export as PDF** | Download any trip page as a print-ready PDF |
| 📅 **Trip Timeline** | All your trips in a chronological timeline on the home page |

---

## How to Use

### 1. Open the App

Visit the live app: **[https://travel-scrapbook-nihar2082.vercel.app](https://travel-scrapbook-nihar2082.vercel.app)**

### 2. Create a New Trip

1. Click **"+ New Trip"** in the top-right corner.
2. Enter a **title** (e.g. *Summer in Portugal*), optional **location**, and **date**.
3. Click **Create** — your new scrapbook page opens automatically.

### 3. Build Your Scrapbook Page

- **Story** — Type your travel memories into the handwritten-style text area.
- **Location & Date** — Fill in where and when you travelled.
- **Photos** — Click the photo area or drag-and-drop image files to add polaroid-style photos.
- **Stickers** — Click any emoji sticker in the tray to place it on your page. Hover a placed sticker and click **×** to remove it.

Changes save automatically as you type or make edits.

### 4. Share a Trip

1. Open a trip page and click **Share 🌍**.
2. Copy the link shown in the dialog.
3. Send it to anyone — they can view your page in any browser, no account needed.

Shared URLs follow the pattern: `https://travel-scrapbook-nihar2082.vercel.app/trip/your-trip-slug`

### 5. Export as PDF

1. Open any trip page.
2. Click **Export PDF ⬇️** in the toolbar.
3. A formatted PDF of your scrapbook page is downloaded instantly.

### 6. Delete a Trip

On the timeline, click **Delete** on any trip card. Confirm to remove it permanently.

---

## Self-Hosting / Development

### Prerequisites

- A [Supabase](https://supabase.com) project with:
  - A `trips` table with RLS policies (set up via the Supabase dashboard or SQL editor)
  - A `trip-photos` storage bucket with **Public bucket** turned ON

### Supabase Setup

1. In your Supabase project, create a table named `trips` with at minimum these columns:

   | Column | Type |
   |---|---|
   | `id` | `uuid` (primary key, default `gen_random_uuid()`) |
   | `title` | `text` |
   | `slug` | `text` |
   | `location` | `text` |
   | `trip_date` | `date` |
   | `story` | `text` |
   | `photos` | `jsonb` |
   | `stickers` | `jsonb` |
   | `is_public` | `boolean` |
   | `created_at` | `timestamptz` (default `now()`) |

2. Create a storage bucket named `trip-photos` and enable **Public bucket**.

3. Run the SQL in `storage-policies.sql` to allow public reads and uploads:

   ```sql
   create policy "Public view trip photos"
   on storage.objects for select to public
   using (bucket_id = 'trip-photos');

   create policy "Public upload trip photos"
   on storage.objects for insert to public
   with check (bucket_id = 'trip-photos');
   ```

4. In `index.html`, update the Supabase credentials near the top of the `<script>` section:

   ```js
   const SUPABASE_URL = 'https://your-project.supabase.co';
   const SUPABASE_PUBLISHABLE_KEY = 'your-publishable-key';
   ```

### Deploy on Vercel

1. Fork or clone this repository.
2. Import it into [Vercel](https://vercel.com) as a **static project**.
3. The included `vercel.json` handles SPA routing for `/trip/*`, `/about`, and `/page`.

### Deploy on Netlify

1. Fork or clone this repository.
2. Drag the folder to [Netlify Drop](https://app.netlify.com/drop), or connect it as a Git-based site.
3. The `public/_redirects` file handles SPA routing automatically.

### Local Test

Open `index.html` directly in a browser for basic use. Note that shared trip URLs (`/trip/slug`) require a server for proper routing — use Vercel or Netlify for full functionality.

---

## Project Structure

```
travel-scrapbook/
├── index.html           # Full single-page app (HTML + CSS + JS)
├── public/
│   └── _redirects       # Netlify SPA routing rule
├── vercel.json          # Vercel SPA routing rules
└── storage-policies.sql # Supabase storage bucket policies
```

---

## Notes

- The Supabase publishable key is safe to include in client-side code — it only grants access defined by your RLS policies.
- All trips are currently created as **public** (readable by anyone with the link). Adjust RLS policies for a private/authenticated setup.
- The database `INSERT`/`UPDATE` policy is open for ease of use as a prototype. For production, restrict writes to authenticated users.
