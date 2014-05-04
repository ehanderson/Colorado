require 'koala'



def renew_long_lived_access_token(access_token)
  oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV["APP_SECRET"])
  long_user_token = oauth.exchange_access_token_info(access_token)["access_token"] # THIS EXPIRES IN 2 MONTHS
  pages = Koala::Facebook::API.new(long_user_token).get_connections('me', 'accounts')
  pages.first['access_token'] # This expires NEVER!!! Wahoooo
end

def page_token(token)
  @page_token ||= renew_long_lived_access_token(token)
end

