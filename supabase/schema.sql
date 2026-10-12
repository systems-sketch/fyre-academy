-- FYRE Academy: run in a dedicated FYRE Supabase project.
-- Account creation uses Supabase Auth (email/password).
-- Each learner can access only their own progress.
create table if not exists public.learner_progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  constraint progress_json_object check (jsonb_typeof(data) = 'object')
);
create index if not exists learner_progress_updated_at_idx on public.learner_progress(updated_at);
alter table public.learner_progress enable row level security;
revoke all on public.learner_progress from anon;
grant select, insert, update, delete on public.learner_progress to authenticated;
drop policy if exists "Learners can select their own progress" on public.learner_progress;
create policy "Learners can select their own progress" on public.learner_progress for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "Learners can insert their own progress" on public.learner_progress;
create policy "Learners can insert their own progress" on public.learner_progress for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Learners can update their own progress" on public.learner_progress;
create policy "Learners can update their own progress" on public.learner_progress for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "Learners can delete their own progress" on public.learner_progress;
create policy "Learners can delete their own progress" on public.learner_progress for delete to authenticated using ((select auth.uid()) = user_id);
