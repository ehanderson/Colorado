namespace :update do
  desc "Update all social media"
  task social_media: [:facebook, :twitter] do
    puts "all social media is up-to-date"
  end

  desc "Pull facebook statuses"
  task facebook: :environment do
    puts "updating facebook statuses..."
    begin
      start_time = Time.now
      Refinery::SocialMediaPosts::SocialMediaPost.pull_facebook_statuses
      puts "retrieved in #{Time.now - start_time}s"
    rescue Exception => e
      Rails.logger.error("FACEBOOK: Something went wrong: #{e.message}")
    end
  end

  desc "Pull tweets"
  task twitter: :environment do
    puts "updating tweets..."
    begin
      start_time = Time.now
      Refinery::SocialMediaPosts::SocialMediaPost.pull_tweets
      puts "retrieved in #{Time.now - start_time}s"
    rescue Exception => e
      Rails.logger.error("TWITTER: Something went wrong: #{e.message}")
    end
  end
end