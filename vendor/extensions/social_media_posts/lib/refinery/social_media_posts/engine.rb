module Refinery
  module SocialMediaPosts
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::SocialMediaPosts

      engine_name :refinery_social_media_posts

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "social_media_posts"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.social_media_posts_admin_social_media_posts_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/social_media_posts/social_media_post'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::SocialMediaPosts)
      end
    end
  end
end
