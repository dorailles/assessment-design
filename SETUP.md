# Setup guide

Follow these in order. The whole thing should take about 20 minutes.

There are three phases:

1. Get the code onto GitHub and turn on GitHub Pages (the shareable link).
2. Create a Supabase project and the database table.
3. Paste your Supabase credentials into `ams-delivery/index.html` and push again.

---

## Phase 1. GitHub

### 1.1 Install git and sign in

Open Terminal (`Cmd+Space`, type "Terminal").

```bash
git --version
```

If you see a version number, you already have git. If a popup asks to install developer tools, click Install and wait a few minutes.

Then tell git who you are. The name is just the label that shows up next to your commits — your real name is fine. The email should match the one on your GitHub account.

```bash
git config --global user.name "Dora Illes"
git config --global user.email "dora.illes@instructure.com"
```

If GitHub later rejects your push with an error about a private email, go to https://github.com/settings/emails, copy the `12345+username@users.noreply.github.com` line, and run `git config --global user.email "<that-noreply-address>"`.

### 1.2 Create the repo on GitHub

1. Go to https://github.com/new
2. Repository name: `assessment-design`
3. Visibility: **Public** (required for free GitHub Pages)
4. Do **not** check "Add a README" — we already have one
5. Click **Create repository**

GitHub will show you a page with setup commands. Keep that tab open.

### 1.3 Push this folder to GitHub

In Terminal, navigate into the `assessment-design` folder:

```bash
cd "/Users/dora.illes/Desktop/CLAUDE CODE/projects/AMS Delivery Settings/assessment-design"
```

Initialize git, commit, and push. Replace `YOUR-USERNAME` with your GitHub username:

```bash
git init
git add .
git commit -m "Initial commit: Assessment Design prototypes"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/assessment-design.git
git push -u origin main
```

The first push will pop up a browser window to sign in to GitHub. Sign in.

### 1.4 Turn on GitHub Pages

1. Go to your repo on GitHub.
2. Click **Settings** (top right of the repo page).
3. In the left sidebar, click **Pages**.
4. Under **Build and deployment** > **Source**, select **Deploy from a branch**.
5. Under **Branch**, pick `main` and `/ (root)`, then click **Save**.
6. Wait 1–2 minutes. Refresh the Pages settings page. You'll see a green box with the URL:

```
https://YOUR-USERNAME.github.io/assessment-design/
```

That's your shareable link. Open it in a new tab. You should see the landing page with a card for AMS Delivery Settings. Click the card. The prototype should load, with a small badge in the bottom-right saying **Supabase not configured** — that's expected. We fix it next.

---

## Phase 2. Supabase

### 2.1 Create an account and a project

1. Go to https://supabase.com and click **Start your project**.
2. Sign in with GitHub (easiest — uses the account you just made).
3. Click **New project**.
   - Name: `assessment-design`
   - Database password: generate one and save it to your password manager
   - Region: pick the one closest to you (e.g., `West EU (Ireland)` or `East US (North Virginia)`)
   - Pricing plan: **Free**
4. Click **Create new project** and wait about 2 minutes for it to provision.

### 2.2 Create the table

1. In the Supabase dashboard, click the **SQL Editor** icon in the left sidebar (it looks like `>_`).
2. Click **New query**.
3. Open `supabase-schema.sql` from this folder, copy everything, and paste it into the SQL editor.
4. Click **Run** (bottom right).

You should see **Success. No rows returned.** That's correct.

### 2.3 Grab your credentials

1. In the left sidebar, click the **gear icon** (Project Settings).
2. Click **API**.
3. You'll see two values you need:
   - **Project URL** (e.g., `https://abcdefghij.supabase.co`)
   - **anon public** key (a long string starting with `eyJ...`)

Keep this tab open.

---

## Phase 3. Wire it up

### 3.1 Paste credentials into the prototype

Open `ams-delivery/index.html` in any text editor. Near the bottom, find this block:

```js
const SUPABASE_URL      = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
const PROTOTYPE_ID      = 'ams-delivery';
```

Replace the two placeholder strings with your Project URL and anon key from step 2.3. Leave `PROTOTYPE_ID` as-is. Save the file.

### 3.2 Push the change

Back in Terminal, from the same `assessment-design` folder:

```bash
git add ams-delivery/index.html
git commit -m "Connect Supabase"
git push
```

Wait about a minute for GitHub Pages to redeploy, then reload the prototype. The badge in the bottom-right should now read **Connected, saved**.

Try toggling a switch or changing a dropdown. Reload the page. Your changes should still be there.

---

## Adding a new prototype later

1. Create a new folder next to `ams-delivery/` (e.g. `gradebook-v2/`) and drop your prototype's HTML in as `index.html`.
2. Copy the Supabase block from the bottom of `ams-delivery/index.html` into your new prototype's HTML and change `PROTOTYPE_ID` to a unique short string (e.g. `'gradebook-v2'`).
3. Open the landing `index.html` at the repo root and add a new card, copying the AMS Delivery one and updating the href, title, and description.
4. Commit and push:

```bash
cd "/Users/dora.illes/Desktop/CLAUDE CODE/projects/AMS Delivery Settings/assessment-design"
git add .
git commit -m "Add gradebook-v2 prototype"
git push
```

---

## A note on the anon key

The Supabase **anon public** key is meant to be shared in client-side code. It's not a secret. Row-level security on the `settings` table is what keeps the data safe — anyone can read and write to that one table, but that's the only thing exposed.

Do not paste the **service_role** key into the HTML. That key has full access to your database and must stay server-side.

---

## Sharing the link

Send people the landing-page URL:

```
https://YOUR-USERNAME.github.io/assessment-design/
```

Or link straight to a specific prototype:

```
https://YOUR-USERNAME.github.io/assessment-design/ams-delivery/
```

Each visitor gets their own session id per prototype, so their changes won't collide with anyone else's.

---

## Updating a prototype later

Any time you edit a file:

```bash
cd "/Users/dora.illes/Desktop/CLAUDE CODE/projects/AMS Delivery Settings/assessment-design"
git add .
git commit -m "Describe what changed"
git push
```

GitHub Pages rebuilds automatically within a minute or two.

---

## Troubleshooting

**Badge says "Supabase not configured"**
You forgot to replace `YOUR_SUPABASE_URL` or `YOUR_SUPABASE_ANON_KEY` in `ams-delivery/index.html`, or you forgot to push the change. Re-check both.

**Badge says "Save error" or "Load error"**
Open browser DevTools (`Cmd+Option+I` in Chrome), click the **Console** tab, and look for the message starting with `[AMS]`. The most common cause is that the SQL didn't run successfully. Re-run the contents of `supabase-schema.sql` in the Supabase SQL Editor.

**GitHub Pages 404s**
GitHub Pages can take a couple of minutes to deploy the first time. If it's still 404 after 5 minutes, check that the landing file is named exactly `index.html` (case-sensitive) and lives at the repo root.

**I want to wipe one prototype's saved settings and start fresh**
Open the prototype, open DevTools Console, and run: `localStorage.removeItem('ams-session-id:ams-delivery'); location.reload();` (swap in the right `PROTOTYPE_ID` for other prototypes).
