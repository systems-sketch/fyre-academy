# FYRE Academy hybrid learning platform

## What works now
- Existing public website and free learning resource catalog remain available at `index.html`.
- `learn.html` provides a personal learning space with a 30-day learning plan, daily completion tracking, skills checklists, and a 5-question practice quiz with scored explanations.
- Guest progress is saved in the same browser with localStorage. Learners can export a JSON backup.
- Visitors do **not** need an account to access the public resources or use guest mode.

## Enable real learner accounts
Use a **dedicated FYRE Academy Supabase project**, not another organization's database.

1. Create a new Supabase project owned by FYRE.
2. In its SQL editor, run `supabase/schema.sql`.
3. Enable Email authentication under Authentication > Providers and configure confirmation emails / allowed site URLs.
4. Copy `config.example.js` to `config.js`, replacing the project URL and the **public anon/publishable key**. Do not use a service role key.
5. Commit the configured `config.js` to the static host (the public key is designed for client apps and security is enforced by RLS). Keep the service_role key private.
6. Verify sign-up, email confirmation, sign-in, sign-out, progress sync, and Row Level Security using two distinct test learners.
7. If deploying from Vercel, static HTML does not require a build command.

Until configured, account UI is deliberately unavailable and progress remains browser-only. Guest progress is not automatically transferred between browsers. When first logging in, the app loads existing cloud progress if present; otherwise it uploads local progress.

## Notes
- The 30-day plan is a guided study checklist based on a learner's goal, experience, and study time, not AI-generated or accredited content.
- The practice assessment is self-evaluation, not certification.
- Data is stored in a single JSONB record per authenticated user with RLS. For more complex course authoring/analytics, migrate to normalized tables.
- Consider adding privacy terms, a deletion process, server-verified graded assessments, and backups before inviting learners to production.
