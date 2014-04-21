class FacebookService
  class << self 
  
    def extend_access_token_expiration(page_token)
      connect_to_oauth.exchange_access_token_info(page_token)
    end

    def get_managed_pages
      connect_to_graph.get_connections('me', 'accounts')
    end

    def get_statuses(access_token)
      connect_to_graph(access_token).get_connections('me', 'statuses')
    end

    def connect_to_graph(access_token)
      Koala::Facebook::API.new(access_token)
    end

    def connect_to_oauth
      Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV["APP_SECRET"])
    end
  end
end