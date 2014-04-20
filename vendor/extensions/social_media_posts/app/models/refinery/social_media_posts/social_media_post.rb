module Refinery
  module SocialMediaPosts
    class SocialMediaPost < Refinery::Core::BaseModel
      self.table_name = 'refinery_social_media_posts'

      attr_accessible :post_date, :platform, :content, :image, :tweet_id, :fb_id, :youtube_id, :likes, :position

      validates :platform, :presence => true
      validates :fb_id, :uniqueness => true
      validates :tweet_id, :uniqueness => true
      validates :youtube_id, :uniqueness => true

      scope :facebook, ->() { where(platfore: 'facebook') }
      scope :youtube,  ->() { where(platfore: 'youtube') }
      scope :twitter,  ->() { where(platfore: 'twitter') }
      scope :recent,   ->(date) { where("post_date <= ?", date)}

      class << self

        def pull_tweets
          $twitter.user_timeline.each do |tweet|
            unless exists?(tweet_id: tweet.id.to_s)
              create!(tweet_id: tweet.id.to_s,
                      content: tweet.text,
                      post_date: tweet.created_at,
                      likes: tweet.favorite_count,
                      image: 'twitter',
                      platform: 'twitter'
              )
            end
          end
        end

        def pull_facebook_statuses
          $facebook.get_connections('me', 'statuses').each do |status|
            unless exists?(fb_id: status['id'])
              create!(fb_id: status['id'],
                      content: status['message'],
                      post_date: status['updated_time'],
                      likes: status['likes']['data'].length,
                      image: 'facebook',
                      platform: 'facebook'
              )
            end
          end
        end

        def pull_youtube_posts

        end
      end
    end
  end
end
