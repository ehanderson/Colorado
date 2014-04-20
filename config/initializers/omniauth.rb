oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV["APP_SECRET"])

access_token = oauth.get_app_access_token

binding.pry

$facebook = Koala::Facebook::API.new(access_token)

$facebook.get_connections('me', 'statuses')
