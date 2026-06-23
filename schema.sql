-- Run this in the Supabase SQL Editor

-- 1. Table that stores metadata for every doodle
create table if not exists public.drawings (
  id uuid primary key default gen_random_uuid(),
  path text not null,
  caption text,
  flagged boolean not null default false,
  created_at timestamptz not null default now()
);

-- 2. Allow public read + insert (since this is an open, anonymous gallery).
--    Disable RLS entirely if you just want the quickest path during development,
--    or keep RLS on and use these narrow policies instead.
alter table public.drawings enable row level security;

create policy "Public can read drawings"
  on public.drawings for select
  using (true);

create policy "Public can submit drawings"
  on public.drawings for insert
  with check (true);

-- 3. Don't forget: create a Storage bucket named "drawings" in the dashboard
--    (Storage -> New bucket) and mark it Public, so getPublicUrl() works.
