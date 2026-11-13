-- Run this script once in Supabase > SQL Editor > New query > Run.
-- Safe to re-run: policies are dropped before being recreated.
create table if not exists public.awf_posts (
  id uuid primary key default gen_random_uuid(),
  title text not null default '',
  description text,
  category text not null default 'Community Welfare',
  media_url text,
  media_type text not null default 'image',
  published boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.awf_posts add column if not exists title text not null default '';
alter table public.awf_posts add column if not exists description text;
alter table public.awf_posts add column if not exists category text not null default 'Community Welfare';
alter table public.awf_posts add column if not exists media_url text;
alter table public.awf_posts add column if not exists media_type text not null default 'image';
alter table public.awf_posts add column if not exists published boolean not null default true;
alter table public.awf_posts add column if not exists created_at timestamptz not null default now();

alter table public.awf_posts enable row level security;

drop policy if exists "Public can view published posts" on public.awf_posts;
create policy "Public can view published posts"
on public.awf_posts for select
to anon, authenticated
using (published = true);

drop policy if exists "Authenticated users can insert posts" on public.awf_posts;
create policy "Authenticated users can insert posts"
on public.awf_posts for insert
to authenticated
with check (true);

drop policy if exists "Authenticated users can update posts" on public.awf_posts;
create policy "Authenticated users can update posts"
on public.awf_posts for update
to authenticated
using (true)
with check (true);

drop policy if exists "Authenticated users can delete posts" on public.awf_posts;
create policy "Authenticated users can delete posts"
on public.awf_posts for delete
to authenticated
using (true);

grant select on public.awf_posts to anon, authenticated;
grant insert, update, delete on public.awf_posts to authenticated;

-- Storage bucket "awf-media" should already exist.
-- These policies allow visitors to fetch published media through signed URLs,
-- while only signed-in users can upload, update or remove files.
drop policy if exists "Public can view AWF media" on storage.objects;
create policy "Public can view AWF media"
on storage.objects for select
to anon, authenticated
using (bucket_id = 'awf-media');

drop policy if exists "Only logged in users can upload AWF media" on storage.objects;
create policy "Only logged in users can upload AWF media"
on storage.objects for insert
to authenticated
with check (bucket_id = 'awf-media');

drop policy if exists "Only logged in users can update AWF media" on storage.objects;
create policy "Only logged in users can update AWF media"
on storage.objects for update
to authenticated
using (bucket_id = 'awf-media')
with check (bucket_id = 'awf-media');

drop policy if exists "Only logged in users can delete AWF media" on storage.objects;
create policy "Only logged in users can delete AWF media"
on storage.objects for delete
to authenticated
using (bucket_id = 'awf-media');
