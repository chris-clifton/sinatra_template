## Sinatra Tailwind + Stimulus Template

A starter Sinatra app that ships with Tailwind CSS (via `sinatra-tailwind`), Stimulus, and esbuild already wired together. Use this repo as a template when you need to spin up a new project quickly.

### Getting Started

1. Create a new project from this template (GitHub: **Use this template**, or clone and remove the existing git history):
   ```bash
   git clone <template-url> my_app
   cd my_app
   rm -rf .git
   git init
   ```
2. Run the automated setup script (copies `env.example` → `.env`, installs gems, installs npm packages, and builds assets):
   ```bash
   bin/setup
   ```
   Or run the steps manually:
   ```bash
   bundle install
   npm install
   npm run build
   ```
3. Give the project its own name (optional, but handy when cloning repeatedly):
   ```bash
   bin/rename_app "Artist Portfolio"
   ```
   The script updates `.env`/`env.example` with `APP_NAME` + `APP_TITLE` and can rename the folder with `--move-dir`.
4. Start the development environment (Rack server + Tailwind + Stimulus bundler):
   ```bash
   ./bin/dev
   ```

The app serves at `http://127.0.0.1:3000` by default when started via `./bin/dev` (Foreman assigns port 3000). Set a `PORT` environment variable if you prefer another port (e.g. `PORT=9292 ./bin/dev`). The rendered page shows a Tailwind-styled “HOME” screen, and the bundled `HomeController` Stimulus controller logs `"hello world"` in the browser console on load—confirming JS integration.

### Docker & Deployment

- **Run everything in Docker for local dev**:
  ```bash
  docker compose up --build
  ```
  Mounts your working directory, reuses Bundler/npm caches via named volumes, and serves at `http://localhost:3000`. Foreman listens on `0.0.0.0`, so host requests hit the container directly. Change the dev port by setting a different `PORT` (e.g. `PORT=5000 docker compose up`).
- **Build a production image**:
  ```bash
  docker build --target production -t my-app \
    --build-arg APP_NAME=$(grep APP_NAME .env | cut -d= -f2) \
    --build-arg APP_TITLE=$(grep APP_TITLE .env | cut -d= -f2 | tr -d '"') .
  docker run -p 3000:8080 --env-file .env -e RACK_ENV=production my-app
  ```
  The production stage precompiles assets and runs `rackup` on port `8080`. Map that to whatever external port you need (e.g. `3000:8080` above) and inject secrets via environment variables.
- **Deploy to Heroku (Container Registry)**:
  ```bash
  heroku container:login
  heroku create my-app-slug
  heroku container:push web --app my-app-slug
  heroku container:release web --app my-app-slug
  ```
  Alternatively, push to Heroku using buildpacks; the included `Procfile` runs the same `bundle exec rackup --host 0.0.0.0 --port ${PORT:-8080}` command.
- **Deploy to DigitalOcean App Platform**: point a new app at this repository. App Platform will detect the Dockerfile (production stage). Remember to set `APP_NAME`, `APP_TITLE`, and `RACK_ENV=production` in the environment tab.
- **Deploy to a Docker host (Droplet, ECS, Fly, etc.)**: install Docker, ship the repo or image, then run `docker compose -f docker-compose.yml up -d` for dev-style workflows or use the production image with `docker run -d -p 3000:8080 --env-file .env my-app`.

### Included Tooling

- **Sinatra** with `sinatra-tailwind` helper for managing Tailwind assets.
- **Tailwind CLI** for styling (`npm run dev:css`, `npm run build:css`), with extended config ready for custom colors.
- **Stimulus** auto-registered through `app/javascript/controllers` (includes a `HomeController` example).
- **esbuild** for JavaScript bundling (`npm run dev:js`, `npm run build:js`).
- **npm-run-all** wrappers for simultaneous dev/build flows (`npm run dev`, `npm run build`).
- **dotenv** support; copy `env.example` to `.env` for environment variables.
- **RSpec + rack-test** ready for request specs (`bundle exec rspec` or `npm test`).
- **Rubocop** with performance + RSpec cops (`bundle exec rubocop`) and interactive debugging tied in with `pry`.

### Common Commands

- `bin/setup` – bootstrap dependencies and build assets.
- `./bin/dev` – run Puma, Tailwind watcher, and JS bundler (serves at `http://127.0.0.1:3000` by default).
- `bin/rename_app "New Name"` – update `APP_NAME` + `APP_TITLE` (add `--move-dir` to rename the folder).
- `npm run dev` – run the CSS and JS watchers in parallel (alternative to `./bin/dev`).
- `npm run build` – compile production-ready assets.
- `docker compose up --build` – run the full dev stack inside containers.
- `bundle exec rspec` / `npm test` – run the test suite.
- `bundle exec rubocop` – lint Ruby code with Rubocop (performance + RSpec cops enabled).

### Structure Notes

- Global layout lives in `views/layout.erb`, yielding to view templates just like Rails' `application.html.erb`.
- Reusable partials (e.g. `_nav.erb`, `_footer.erb`) can be rendered with `render_partial`.
- Add new environment variables by copying `env.example` → `.env`.

Feel free to extend the controllers, add routes in `app.rb`, and customize the layout, Tailwind theme, or Stimulus controllers as needed for new projects.

