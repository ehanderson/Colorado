class ChangeSocialMediaDataTypes < ActiveRecord::Migration
  def up
    change_column :refinery_social_media_posts, :platform, :string
    change_column :refinery_social_media_posts, :tweet_id, :string
    change_column :refinery_social_media_posts, :fb_id, :string
    change_column :refinery_social_media_posts, :youtube_id, :string
  end

  def down
  end
end
