class AddLikesColumnToRefinerySocialMediaPostsSocialMediaPost < ActiveRecord::Migration
  def change
    add_column :refinery_social_media_posts, :likes, :integer
  end
end
