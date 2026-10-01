# Posts · Rails learning project

Historical Ruby on Rails exercise for creating and browsing posts. The repository contains a `PostsController` with CRUD actions, a `Post` model, Devise user authentication, ERB views and image handling through Active Storage.

## Stack and scope

- Ruby 2.7.0 and Rails 6.0, as declared in the Gemfile
- SQLite in development and test; PostgreSQL dependency for production
- Devise, Webpacker and Rails views

This is an older learning project, not a maintained production service. The repository does not document a live deployment.

## Run locally

Install Ruby 2.7.0 and Bundler, then use `bundle install`, `bin/rails db:setup` and `bin/rails server`. The JavaScript dependencies are declared in `package.json`; install them with Yarn if the asset build requires it. These steps reflect the repository configuration and have not been revalidated against current toolchains.
