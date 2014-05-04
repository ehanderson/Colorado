module Refinery
  module SocialMediaPosts
    class SocialMediaPost < Refinery::Core::BaseModel
      self.table_name = 'refinery_social_media_posts'

      attr_accessible :post_date, :platform, :content, :image, :tweet_id, :fb_id, :youtube_id, :likes, :position, :title

      validates :platform, :presence => true

      scope :facebook, ->() { where(platform: 'facebook') }
      scope :youtube,  ->() { where(platform: 'youtube') }
      scope :twitter,  ->() { where(platform: 'twitter') }
      scope :recent,   ->(date) { where("post_date <= ?", date)}

      default_scope order: 'post_date desc'

      class << self

        def pull_tweets
          begin
            $twitter.user_timeline.each do |tweet|
              unless exists?(tweet_id: tweet.id.to_s)
                create!(tweet_id: tweet.id.to_s,
                        content: tweet.text,
                        post_date: tweet.created_at,
                        likes: tweet.favorite_count,
                        image: 'twitter',
                        platform: 'twitter',
                        title: 'tweet' )
              end
            end
          rescue
            Rails.logger.warn('Twitter access token is bad')
          end
        end

        def pull_facebook_statuses
          begin
            statuses = FacebookService.get_statuses($FB_PAGE_TOKEN)
            statuses.each do |status|
              unless exists?(fb_id: status['id'])
                create!(fb_id: status['id'], 
                        platform: 'facebook', 
                        content: status['message'],
                        post_date: status['updated_time'],
                        likes: !status['likes'].nil? ? status['likes']['data'].length : nil,
                        image: 'facebook',
                        platform: 'facebook',
                        title: 'facebook status')
              end
            end
          rescue
            Rails.logger.warn('Facebook access token has expired')
          end
        end

      end
    end
  end
end
