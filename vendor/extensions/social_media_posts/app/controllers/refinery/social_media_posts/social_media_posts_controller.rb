module Refinery
  module SocialMediaPosts
    class SocialMediaPostsController < ::ApplicationController

      before_filter :find_all_social_media_posts
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @social_media_post in the line below:
        present(@page)
      end

      def show
        @social_media_post = SocialMediaPost.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @social_media_post in the line below:
        present(@page)
      end

    protected

      def find_all_social_media_posts
        @social_media_posts = SocialMediaPost.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/social_media_posts").first
      end

    end
  end
end
