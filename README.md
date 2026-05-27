# Assessment Design

Clickable HTML prototypes of upcoming Canvas assessment experiences, hosted on GitHub Pages and backed by Supabase for persistence.

## Layout

```
assessment-design/
  index.html              landing page that links to every prototype
  supabase-schema.sql     run once in Supabase to create the settings table
  SETUP.md                one-time setup instructions
  ams-delivery/
    index.html            the AMS Delivery Settings prototype
```

Each prototype lives in its own subfolder with its own `index.html`. GitHub Pages serves them as separate URLs:

- `https://YOUR-USERNAME.github.io/assessment-design/` — the landing page
- `https://YOUR-USERNAME.github.io/assessment-design/ams-delivery/` — the AMS Delivery Settings prototype

## How persistence works

Every prototype shares one `settings` table in Supabase. Each prototype is assigned a `PROTOTYPE_ID` near the top of its `index.html`; the prototype id is mixed into the session id, so the same browser visiting two different prototypes will save to two different rows. No collisions.

There's no login. Each visitor gets their own random session id stored in `localStorage`, and the prototype reads and writes that one row on every change.

## Adding a new prototype

1. Create a new folder next to `ams-delivery/`, e.g. `gradebook-v2/`.
2. Drop your prototype's HTML in there as `index.html`.
3. Add the same Supabase persistence block at the bottom (copy it from `ams-delivery/index.html`) and change `PROTOTYPE_ID` to a unique short string.
4. Add a card to `index.html` at the repo root so it shows up on the landing page.
5. Commit and push. GitHub Pages will deploy it automatically.

## Quick start

Open `SETUP.md` and follow the steps in order.
