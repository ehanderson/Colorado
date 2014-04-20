module Refinery
  module SocialMediaPosts
    module Admin
      class SocialMediaPostsController < ::Refinery::AdminController

        crudify :'refinery/social_media_posts/social_media_post',
                :title_attribute => 'platform',
                :xhr_paging => true

      end
    end
  end
end
