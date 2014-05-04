class AddTitleToSocialMediaPosts < ActiveRecord::Migration
  def change
    add_column :refinery_social_media_posts, :title, :string
  end
end
