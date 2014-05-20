module Refinery
  module Salsas
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Salsas

      engine_name :refinery_salsas

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "salsas"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.salsas_admin_salsas_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/salsas/salsa'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Salsas)
      end
    end
  end
end
