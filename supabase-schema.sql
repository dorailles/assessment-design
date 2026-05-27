-- Supabase schema for AMS Delivery Settings prototype
-- Run this once in: Supabase dashboard > SQL Editor > New query > paste > Run

-- 1. Settings table: one row per browser session, all UI state stored as JSON
create table if not exists public.settings (
  id          uuid primary key default gen_random_uuid(),
  session_id  text not null unique,
  data        jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- 2. Helpful index on session_id for fast lookup
create index if not exists settings_session_id_idx on public.settings (session_id);

-- 3. Row-level security: enable it, then allow anonymous read/write
--    This is fine for a prototype. For production, swap in Supabase Auth
--    and scope policies to auth.uid().
alter table public.settings enable row level security;

drop policy if exists "anon read settings"   on public.settings;
drop policy if exists "anon insert settings" on public.settings;
drop policy if exists "anon update settings" on public.settings;

create policy "anon read settings"
  on public.settings for select
  to anon using (true);

create policy "anon insert settings"
  on public.settings for insert
  to anon with check (true);

create policy "anon update settings"
  on public.settings for update
  to anon using (true) with check (true);
