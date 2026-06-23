# The Doodle Wall

A tiny public doodle gallery: draw something, give it a title, and it gets
framed and hung &mdash; both in a "Just Hung" grid and in an infinitely
scrolling marquee of every doodle ever submitted. Built with vanilla
HTML/CSS/JS, Vite, and Supabase (Postgres + Storage).

## 1. Set up Supabase

1. Create a project at [supabase.com](https://supabase.com).
2. **Storage** &rarr; New bucket &rarr; name it `drawings` &rarr; mark it **Public**.
3. **SQL Editor** &rarr; paste and run `schema.sql` from this folder.
4. **Project Settings &rarr; API** &rarr; copy your Project URL and `anon` public key.

## 2. Configure the app

```bash
cp .env.example .env
```

Edit `.env` and paste in your real values:

```
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

## 3. Install and run

```bash
npm install
npm run dev
```

Open the printed `localhost` URL in your browser.

## How it's organized

| File | What it does |
|---|---|
| `index.html` | Page structure: drawing studio, recent grid, marquee wall |
| `style.css` | Gallery-wall theme, four pure-CSS picture frame styles, marquee animation |
| `src/supabaseClient.js` | Creates the Supabase client from your `.env` values |
| `src/utils.js` | `escapeHtml`, `shuffleArray`, square-crop export, blank-canvas detection |
| `src/frames.js` | Frame style definitions + random/deterministic pickers |
| `src/main.js` | Canvas drawing, `submitDrawing()`, `loadGallery()`, the marquee logic |
| `schema.sql` | The `drawings` table + storage policies, ready to paste into Supabase |

## Notes

- Frames are drawn entirely in CSS (`.frame--gilded`, `.frame--walnut`,
  `.frame--arch`, `.frame--simple` in `style.css`) instead of frame image
  assets, so there's nothing extra to source or host.
- If submissions fail with a permissions error, double check the RLS
  policies in `schema.sql` ran successfully, or temporarily disable RLS on
  the `drawings` table while developing.
- Deploy anywhere that serves a Vite app (Vercel, Netlify, etc.) &mdash; just
  remember to set the two `VITE_SUPABASE_*` environment variables there too.
