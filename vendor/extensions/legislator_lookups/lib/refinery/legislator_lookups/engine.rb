module Refinery
  module LegislatorLookups
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::LegislatorLookups

      engine_name :refinery_legislator_lookups

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "legislator_lookups"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.legislator_lookups_admin_legislator_lookups_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/legislator_lookups/legislator_lookup',
            :title => 'zipcode'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::LegislatorLookups)
      end
    end
  end
end
