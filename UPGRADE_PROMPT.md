# Rails 3.1 to 4.2 Upgrade Prompt for Claude Code

Please upgrade this Rails 3.1.0 application to Rails 4.2. This is a legacy embroidery design management application that needs to continue functioning - it does not need to follow modern conventions, just work reliably.

## Context

This is a small Rails 3.1.0 app with:
- 7 models, 6 controllers, 29 views
- Paperclip for file attachments (5 attachments per Diseno model)
- SQLite3 database
- HAML views
- Custom caching plugin (vendor/plugins/coto_solutions)
- timeline_fu for activity tracking

## Required Changes

### 1. Gemfile Updates
- Update `gem 'rails'` from `'3.1.0'` to `'4.2.11.3'` (last secure 4.2 release)
- Add `gem 'rails-observers'` for sweepers compatibility
- Add `gem 'actionpack-page_caching'` for page caching compatibility
- Add `gem 'actionpack-action_caching'` for action caching compatibility
- Add `gem 'protected_attributes'` for easier migration (optional but recommended)
- Update `gem 'sass'` to `'~> 3.4'`
- Update `gem 'coffee-script'` to `'~> 2.4'`
- Update `gem 'uglifier'` to `'~> 4.1'`
- Update `gem 'jquery-rails'` to `'~> 4.3'`
- Keep Paperclip at 4.2.2 or update to `'~> 5.0'` if compatible
- Verify timeline_fu compatibility or pin version

### 2. Configuration Files

**config/application.rb:**
- Add `config.active_record.raise_in_transactional_callbacks = true`

**config/environments/development.rb:**
- Remove `config.whiny_nils` (deprecated)
- Remove `config.action_dispatch.best_standards_support` (deprecated)
- Add `config.eager_load = false`

**config/environments/production.rb:**
- Add `config.eager_load = true`
- Add `config.assets.js_compressor = :uglifier`
- Add `config.assets.compile = false`

**config/environments/test.rb:**
- Add `config.eager_load = false`

**config/secrets.yml (NEW FILE):**
- Create this file with secret_key_base for development, test, and production
- Move secret token from initializers to this file

### 3. Remove Deprecated Features

**RJS Templates** - Convert these 2 files to .js.erb:
- `app/views/javascripts/colores.js.rjs` → `colores.js.erb`
- `app/views/javascripts/add_colors.js.rjs` → `add_colors.js.erb`

Convert Prototype.js syntax to jQuery:
- `page.replace_html "hilos", :partial => 'disenos/hilo'` → `$("#hilos").html("<%= j render 'disenos/hilo' %>");`
- `page << "select_colors();"` → `select_colors();`
- `page[:colors].replace_html :partial => 'hilos/colors'` → `$("#colors").html("<%= j render 'hilos/colors' %>");`

**render :update blocks** in `app/controllers/javascripts_controller.rb`:
- Convert `email_image` action's `render :update` block to respond with .js.erb template
- Create `app/views/javascripts/email_image.js.erb` with jQuery equivalents

### 4. Migration Updates

Convert all 12 migrations from old syntax to new syntax:
- Change `def self.up` → `def up`
- Change `def self.down` → `def down`
- OR convert simple migrations to `def change` where possible

Files to update:
- `db/migrate/001_create_disenos.rb` through `db/migrate/20110421200512_add_names_upload_file.rb`

### 5. Model Updates

**app/models/letter.rb:**
- Replace `Diseno.find(:all, :conditions => [...], :order => ...)` with:
  ```ruby
  Diseno.where("nombre_de_orden LIKE ?", @char + '%').order("nombre_de_orden")
  ```

**All models (if needed):**
- Verify no `attr_accessible` is needed (you found none, which is good)
- If strong parameters are causing issues, add `gem 'protected_attributes'` to Gemfile

### 6. Controller Updates

**app/controllers/application_controller.rb:**
- Change `before_filter` → `before_action`

**Sweepers (app/sweepers/):**
- Add `gem 'rails-observers'` to Gemfile to maintain sweeper functionality
- Sweepers should continue working with this gem

**Strong Parameters:**
- Add private permit methods to controllers for mass assignment:
  - `disenos_controller.rb`: `def diseno_params; params.require(:diseno).permit(:nombre_de_orden, :image, :original, :archivo_dst, :archivo_pes, :names, :notas, hilos_attributes: [:id, :color_id, :marca_id, :_destroy]); end`
  - `hilos_controller.rb`: `def marca_params; params.require(:marca).permit(:nombre, colors_attributes: [:id, :nombre, :codigo, :hex, :marca_id, :_destroy]); end`
  - Update `params[:diseno]` → `diseno_params` in create/update actions
  - Update `params[:marca]` → `marca_params` in create/update actions

OR add `gem 'protected_attributes'` to avoid strong parameters for now.

### 7. Routes

**config/routes.rb:**
- Verify no deprecated routing syntax exists
- Current routes look compatible with Rails 4.2

### 8. Asset Pipeline

**app/assets/javascripts/application.js:**
- Change `//= require jquery3` → `//= require jquery` (Rails 4.2 uses jquery-rails gem)
- Verify jquery_ujs is loaded

### 9. Vendor Plugin Migration

**vendor/plugins/coto_solutions:**
- Option 1: Leave as-is and add plugin loading support
- Option 2: Move to `lib/` and convert to initializer
- For now, try leaving it and see if it loads; Rails 4.2 deprecated plugins but they may still work

### 10. Testing Strategy

After making changes:
1. Run `bundle install`
2. Run `bundle exec rake db:migrate RAILS_ENV=development`
3. Run `bundle exec rake db:test:prepare`
4. Start server: `bundle exec rails server`
5. Test critical workflows:
   - Create new design (diseno)
   - Upload files
   - Add thread colors (hilos)
   - View design details
   - Search functionality
   - AJAX color selection
6. Check logs for deprecation warnings
7. Run test suite: `bundle exec rake test`

## Important Notes

- **Do NOT modify the database schema** - only update migration syntax
- **Keep file paths for Paperclip attachments** - existing uploads must continue working
- **Preserve Spanish localization** (I18n.locale = 'es')
- **Maintain caching behavior** - sweepers and page caching are important
- **Test file uploads thoroughly** - Paperclip compatibility is critical
- **The timeline_fu gem may need pinning** to a specific version if issues arise

## Order of Operations

1. Update Gemfile
2. Run `bundle update`
3. Update config files (application.rb, environments/*, create secrets.yml)
4. Update migrations (syntax only)
5. Convert RJS files to .js.erb
6. Update email_image action and create .js.erb template
7. Add strong parameters to controllers (or add protected_attributes gem)
8. Change before_filter → before_action
9. Update deprecated finder in letter.rb
10. Test thoroughly

## Expected Outcome

A working Rails 4.2.11.3 application with:
- All existing functionality preserved
- Same file attachment behavior
- Compatible with Ruby 2.2-2.4
- Reduced technical debt
- Foundation for future upgrades if needed

## If Issues Arise

- Check Rails 4.2 upgrade guides: https://guides.rubyonrails.org/upgrading_ruby_on_rails.html#upgrading-from-rails-3-2-to-rails-4-0
- For Paperclip issues, verify file storage paths in `public/system/`
- For plugin issues, may need to extract coto_solutions to lib/
- For timeline_fu issues, consider replacing with simple callbacks
- Run `bundle exec rake rails:update` to see suggested config changes
