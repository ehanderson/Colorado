module Refinery
  module LegFinders
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::LegFinders

      engine_name :refinery_leg_finders

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "leg_finders"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.leg_finders_admin_leg_finders_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/leg_finders/leg_finder',
            :title => 'zip'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::LegFinders)
      end
    end
  end
end
