require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dns5
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller
    config.time_zone = 'Kuala Lumpur'
    config.active_record.default_timezone = :local
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
      
    config.active_job.queue_adapter = Rails.env.production? ? :sidekiq : :async
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

