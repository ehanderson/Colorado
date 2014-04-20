require 'refinerycms-core'

module Refinery
  autoload :SocialMediaPostsGenerator, 'generators/refinery/social_media_posts_generator'

  module SocialMediaPosts
    require 'refinery/social_media_posts/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
