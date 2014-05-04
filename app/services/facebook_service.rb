class FacebookService
  class << self 
    def get_statuses(access_token)
      @graph ||= Koala::Facebook::API.new(access_token).get_connections('me', 'statuses')
    end
  end
end
