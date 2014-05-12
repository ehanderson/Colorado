# $salsa = SalsaLabs.configure do |config|
#   config.email    = ENV["SALSA_EMAIL"]
#   config.password = ENV["SALSA_PASSWORD"]
# end
# $client = SalsaLabs::ApiClient.new({email: 'anderson.emilyhi@gmail.com', password: '&erson813'})
# https://sandbox.salsalabs.com/api/authenticate.sjs?email=andrson.emilyhi@gmail.com&password=&erson813

# supporters = SalsaLabs::Supporter.all

# supporter_KEY = supporters.first["supporter_KEY"]

# SalsaLabs::Supporter.get(supporter_KEY)
module SalsaLabs
  class Authentication
    attr_reader :email, :password, :host, :authenticated

    def initialize(credentials = {})
      @email = credentials[:email]
      @password = credentials[:password]
      @host = "https://hq-salsa4.salsalabs.com"

      @authenticated = authenticate! 
    end

    def authenticate!
      return true if @authenticated

      response = connection.get("/api/authenticate.sjs", { email: @email, password: @password })
      @authentication_cookie = response.env[:response_headers]["set-cookie"]

      Nokogiri::XML(response.body).css('error').empty?
    end

    def connection
      @connection ||= 
      Faraday.new(url: @host) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter   Faraday.default_adapter # make requests with Net::HTTP
      end
    end

    def get_email_blasts
      binding.pry
      get_request("getObjects.sjs", {object: 'Supporter'})
      binding.pry
    end

    def get_request(endpoint, params)
      response = connection.get do |request|
        request.headers['cookie'] = @authentication_cookie
        request.url(endpoint, params)
      end
    end

  end
end

email    = ENV["SALSA_LABS_API_EMAIL"]
password = ENV['SALSA_LABS_API_PASSWORD']

client = SalsaLabs::Authentication.new({email: email, password: password })

binding.pry

client.get_email_blasts

# client = SalsaLabs::ApiClient.new({email: email, password: password })

# client.fetch('getObjects.sjs', {object: 'email_blast'})

##################### DO NOT DELETE THE COMMENTED CODE BELOW ###############################
# client = SalsaLabs::ApiClient.new({email: 'pollyk@strategies360.com', password: 'apple'})
# @trial_client = client.fetch('getObjects.sjs', {object: 'Supporter'})
# SalsaLabs::Supporter.all
# @support = $client.fetch('getObjects.sjs', {object: 'Supporter'})
# client = SalsaLabs::ApiClient.new({email: 'anderson.emilyhi@gmail.com', password: '&erson813'})
# @support = client.fetch('getObjects.sjs', {object: 'Supporter'})
# RestClient.get 'https://sandbox.salsalabs.com/api/authenticate.sjs?xml&email=anderson.emilyhi@gmail.com&password=&erson813'
# @trial_client =  RestClient.get 'https://hq-salsa4.salsalabs.com/api/getObject.sjs?xml&object=supporter&key=62988113'
# @trial_client = RestClient.get 'https://sandbox.salsalabs.com/api/authenticate.sjs?xml&email=anderson.emilyhi@gmail.com&password=&erson813'
# @trial_client =  RestClient.get 'https://hq-salsa4.salsalabs.com/api/describe2.sjs?object=supporter'
# RestClient.get 'https://hq-salsa4.salsalabs.com/api/authenticate.sjs?&email=pollyk@strategies360.com&password=apple'
# @trial_client =  RestClient.get 'https://hq-salsa4.salsalabs.com/api/getObject.sjs?xml&object=supporter&key=62988113'