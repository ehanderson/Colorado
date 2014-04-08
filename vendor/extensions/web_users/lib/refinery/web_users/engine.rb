module Refinery
  module WebUsers
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::WebUsers

      engine_name :refinery_web_users

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "web_users"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.web_users_admin_web_users_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/web_users/web_user',
            :title => 'role'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::WebUsers)
      end
    end
  end
end
