# Proyect · Rails posts exercise

This repository is a learning app for posts and Devise accounts. It is not confirmed to have a live deployment.

## Local development

- Ruby 3.4.2, Bundler, and SQLite
- Rails 8.1.4, Devise 5.0.4, Propshaft, and Importmap
- `bundle install`
- `RAILS_ENV=test bin/rails db:prepare && bin/rails test`
- `bin/rails db:prepare && bin/rails server`

No Node or Yarn build is required. The repository includes a GitHub Actions job for tests, asset compilation, and a current Ruby advisory check.

## Upgrade and deployment review

This upgrade replaces Rails 6.0/Ruby 2.7 and Webpacker/Turbolinks. It removes the `pages` resource route, which referenced a missing `Page` model; the homepage remains. Bootstrap's CSS CDN remains, while the old jQuery tooltip/popover behavior is no longer initialized. Check the UI and Devise account flows before merging. The application retains Rails 6.0 configuration defaults; review them incrementally for any future behavior changes.

Production now requires a separately managed PostgreSQL `DATABASE_URL` and a securely provided Rails secret. Local SQLite data will **not** move automatically. Back up and migrate any real database explicitly before switching providers. Active Storage still writes uploads to local disk; those files are lost on an ephemeral host, so choose persistent object storage and plan a data transfer before deploying. `config.force_ssl` is enabled. No production database migration or deployment is included in this PR.

Devise password resets require outbound email, which is not configured for a free host; [Render Free blocks common SMTP ports](https://render.com/docs/free). Choose a permitted HTTP email service and its credentials before relying on password recovery. No custom jobs or Action Cable subscriptions exist; the generated production Cable config still references Redis and would need review if real-time features are added.

Before rollout, confirm the existing app and database, verify authentication and uploads against a staging copy, and retain a rollback deployment plus a database backup. Reverting application code alone does not reverse a data transfer or schema change. The dependency audit only checks known advisories at the time it runs; it does not prove the application is fully secure.
