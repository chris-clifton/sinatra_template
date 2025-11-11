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
2. Run the automated setup script (runs Bundler, npm install, and builds assets):
   ```bash
   bin/setup
   ```
   Or run the steps manually:
   ```bash
   bundle install
   npm install
   npm run build
   ```
3. Start the development environment (Rack server + Tailwind + Stimulus bundler):
   ```bash
   ./bin/dev
   ```

The app serves at `http://127.0.0.1:5000` by default when started via `./bin/dev` (Foreman assigns port 5000). Set a `PORT` environment variable if you prefer another port (e.g. `PORT=9292 ./bin/dev`). The rendered page shows a Tailwind-styled “HOME” screen, and the bundled `HomeController` Stimulus controller logs `"hello world"` in the browser console on load—confirming JS integration.

### Included Tooling

- **Sinatra** with `sinatra-tailwind` helper for managing Tailwind assets.
- **Tailwind CLI** for styling (`npm run dev:css`, `npm run build:css`), with extended config ready for custom colors.
- **Stimulus** auto-registered through `app/javascript/controllers` (includes a `HomeController` example).
- **esbuild** for JavaScript bundling (`npm run dev:js`, `npm run build:js`).
- **npm-run-all** wrappers for simultaneous dev/build flows (`npm run dev`, `npm run build`).
- **dotenv** support; copy `.env.example` to `.env` for environment variables.
- **RSpec + rack-test** ready for request specs (`bundle exec rspec` or `npm test`).
- **Rubocop** with performance + RSpec cops (`bundle exec rubocop`) and interactive debugging tied in with `pry`.

### Common Commands

- `bin/setup` – bootstrap dependencies and build assets.
- `./bin/dev` – run Puma, Tailwind watcher, and JS bundler.
- `npm run dev` – run the CSS and JS watchers in parallel (alternative to `./bin/dev`).
- `npm run build` – compile production-ready assets.
- `bundle exec rspec` / `npm test` – run the test suite.
- `bundle exec rubocop` – lint Ruby code with Rubocop (performance + RSpec cops enabled).

### Structure Notes

- Global layout lives in `views/layout.erb`, yielding to view templates just like Rails' `application.html.erb`.
- Reusable partials (e.g. `_nav.erb`, `_footer.erb`) can be rendered with `render_partial`.
- Add new environment variables by copying `.env.example` → `.env`.

Feel free to extend the controllers, add routes in `app.rb`, and customize the layout, Tailwind theme, or Stimulus controllers as needed for new projects.

