require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blogster
  class Application < Rails::Application
    # Load the app's custom environment variables here, so that they are loaded before environments/*.rb
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      if File.exist?(env_file)
        env_vars = YAML.load(File.open(env_file))
        env_vars[Rails.env].each { |key, value| ENV[key] = value }
      end
    end
    config.assets.enabled = true
    config.assets.compile = true
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
