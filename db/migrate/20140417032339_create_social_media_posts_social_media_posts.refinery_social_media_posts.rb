# This migration comes from refinery_social_media_posts (originally 1)
class CreateSocialMediaPostsSocialMediaPosts < ActiveRecord::Migration

  def up
    create_table :refinery_social_media_posts do |t|
      t.datetime :post_date
      t.text :platform
      t.text :content
      t.text :image
      t.text :tweet_id
      t.text :fb_id
      t.text :youtube_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-social_media_posts"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/social_media_posts/social_media_posts"})
    end

    drop_table :refinery_social_media_posts

  end

end
