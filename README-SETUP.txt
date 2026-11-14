# AWF website with one-time media upload setup

## Included
- `index.html`: original AWF website with an Activity Gallery section added; existing brand assets and visual styling are retained.
- `admin.html`: private sign-in page for uploading activity photos/videos.
- `supabase-config.js`: project URL and publishable key.
- `supabase-setup.sql`: database and Storage access policies.

## One-time Supabase setup
1. Confirm the `awf-media` Storage bucket exists. The current bucket has a 50 MB per-file limit.
2. In Supabase, open SQL Editor > New query.
3. Copy all of `supabase-setup.sql` into the editor and click Run.
4. In Database > Tables, open `awf_posts` and ensure its **Data API access** is enabled if the dashboard shows that toggle.
5. Authentication > Users: use the admin user you created. Keep public sign-ups disabled. Do not create public accounts.
6. Authentication > URL Configuration: add your deployed website origin and the admin page URL to the allowed redirect/site URL configuration if Supabase asks for it.

## Deploy
Upload all files and the `assets` folder to the root of your GitHub Pages repository, preserving the folder structure. Do not upload only index.html.
Then visit:
- Public site: `https://YOUR-GITHUB-PAGES-ADDRESS/`
- Admin page: `https://YOUR-GITHUB-PAGES-ADDRESS/admin.html`

## Uploading
1. Open `admin.html` and sign in with the email/password of the Supabase user you created.
2. Choose a photo/video, enter a title, select category, and click Upload & Publish.
3. Refresh the public site's Activity Gallery. Published media appears there automatically.

## Important security
- The publishable key in `supabase-config.js` is intended for browser use. Keep Row Level Security enabled.
- NEVER put a Supabase secret/service-role key or database password in website files or chat.
- Keep Supabase public sign-ups disabled. Only the admin account should be able to upload.
- Existing files are preserved in the `assets` folder. This package does not change the original logo, donation QR or WhatsApp QR.
