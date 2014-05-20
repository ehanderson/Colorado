namespace :update do
  task salsa: :environment do
    puts 'updating salsa eNewsletters database...'
    begin
      start_time = Time.now
      Refinery::Salsas::Salsa.pull_enewsletters
      puts "retrieved in #{Time.now - start_time}s"
    rescue Exception => e
      Rails.logger.error("Salsa: something went wrong: #{e.message}")
    end
  end
end







