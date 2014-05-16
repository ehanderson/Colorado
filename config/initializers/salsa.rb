# THESE SHOULD ALL WORK, AND YET.... DON'T=

# ============= ATTEMPT #1 RestClient =================== #

# # # authenticated response
response = RestClient.get 'https://hq-salsa4.salsalabs.com/api/authenticate.sjs?&email=pollyk@strategies360.com&password=apple'
cookie = response.cookies
t = RestClient.get("https://hq-salsa4.salsalabs.com/api/getObjects.sjs?xml&object=email_blast",
                cookies: cookie
              )
w = Hash.from_xml(t).to_json
parsed_response = JSON.parse(w)
$all_blasts = parsed_response['data']['email_blast']['item'].reverse
# p parsed_response['data']['email_blast']['item'].first
# $blast = parsed_response['data']['email_blast']['item'].last
# binding.pry

# $blast_key = parsed_response['data']['email_blast']['item'].last['email_blast_KEY']
# $blast_key = parsed_response['data']['email_blast']['item'].last['Date_Requested']
# $blast_key = parsed_response['data']['email_blast']['item'].last['Subject']
# <a href= "http://salsa4.salsalabs.com/o/51084/t/0/blastContent.jsp?email_blast_KEY=#{$blast_key}" target = "_blank"> Link to most recent blast</a>






































# # as soon as you try to interact with them it does not stay authenticated

# # use cookie with either a POST or GET to retrieve objects - BROKEN
# t = RestClient.get("https://hq-salsa4.salsalabs.com/api/describe2.sjs?xml&object=supporter&key=63053613",
#                 {:cookies => {:session_id => cookie["JSESSIONID"] }}
#               )

# ============= ATTEMPT #2 MarcLove Ruby Gem # https://github.com/marclove/salsalabs =================== ##

# set up configuration for gem -> it properly authenticates
# SalsaLabs.configure do |config|
#   config.email    = 'anderson.emilyhi@gmail.com' # ENV["SALSA_LABS_API_EMAIL"]
#   config.password = '&erson813' # ENV['SALSA_LABS_API_PASSWORD']
# end

# SalsaLabs::Supporter.all # => gives us all supporters! YAY!!

# USING LIB IN GEM, USE REQUEST METHOD TO RETRIEVE DATA (WHICH IS EXACTLY WHAT ::SUPPORTER.ALL CALLS)
# DOESN'T WORK
# def email_blast
#   object_name = "supporter"
# this is the method the gem calls but it does not do what the gem does
#   SalsaLabs.request("api/getObjects.sjs", {object: "supporter"}) do |response|
#     Hash.from_xml(response).
#          try(:[], "supporter").
#          try(:[], 'count').
#          try(:[], 'count').
#          try(:to_i)
#   end
# end

# THOUGHT THERE MIGHT BE SOMETHING FUNNY GOING ON WITH HOW OBJECT_NAME IS USED -> FALSE
# module Salsa
#   class Supporter
#     def class_name
#       self.to_s.split('::').last.gsub(/(?:([A-Za-z])|^)(?=[^a-z])/) { "#{$1}#{$1 && '_'}" }.downcase
#     end
#   end
# end

# ============= ATTEMPT #3 Velocity Ruby Gem # https://github.com/VelocityStrategies/ruby-salsa_labs =================== ##

# $client = SalsaLabs::ApiClient.new({email: 'pollyk@strategies360', password: 'apple'}) # => doesn't autmocatically authenticate; need to call it manually
# $client.authenticate # => doesn't authenticate
# binding.pry
# $client.fetch('getObjects.sjs', {object: 'email_blast'}) # => Would love for this to happen... psych

# ============= ATTEMPT #4 TRYING TO RECREATE OWN GEM LEVERAGING GEMS & FARADAY =================== ##

# Faraday: https://github.com/lostisland/faraday
# Salsa Gem: https://github.com/VelocityStrategies/ruby-salsa_labs/
# Salsa Gem Authentication: https://github.com/VelocityStrategies/ruby-salsa_labs/blob/master/lib/salsa_labs/api_client.rb

# module SalsaLabs
#   class Authentication
#     attr_reader :email, :password, :host, :authenticated

#     def initialize(credentials = {})
#       @email = credentials[:email]
#       @password = credentials[:password]
#       @host = "https://sandbox.salsalabs.com" # https://hq-salsa.wiredforchange.com
#       @connection = connect!
#       @authenticated = authenticate!
#     end

#     def get_email_blasts
#       get_request("getObjects.sjs", {object: 'Supporter'}).body
#     end

#     private

#     def connect!
#       connection =
#       Faraday.new(url: @host) do |faraday|
#         faraday.request  :url_encoded             # form-encode POST params
#         faraday.response :logger                  # log requests to STDOUT
#         faraday.adapter   Faraday.default_adapter # make requests with Net::HTTP
#       end
#     end

#     def authenticate!
#       return true if @authenticated

#       response = @connection.get("/api/authenticate.sjs", { email: @email, password: @password })
#       binding.pry
#       # RESPONSE XML SAYS LOGIN SUCCESSFUL
#       # RESPONSE SENDS US BACK THE COOKIE OK
#       # MAYBE FURTHER PARSE THE COOKIE?
#       @authentication_cookie = response.headers["set-cookie"]

#       Nokogiri::XML(response.body).css('error').empty?
#     end

#     def get_request(endpoint, params)
#       response = @connection.get do |request|
#         request.headers['cookie'] = @authentication_cookie
#         request.url(endpoint, params)
#       end
#     end

#   end
# end

# email    = ENV["SALSA_LABS_API_EMAIL"]
# password = ENV['SALSA_LABS_API_PASSWORD']

# client = SalsaLabs::Authentication.neord }) # => Authntication WORKS, YAY!!

# you can stll never get supporter

# blasts = client.get_email_blasts # => RENDERS A 404 ERROR IN RESPONSE BODY

# ============= ATTEMPT #5 OTHER NOTES =================== ##

##################### DO NOT DELETE THE COMMENTED CODE BELOW ###############################
# client = SalsaLabs::ApiClient.new({email: 'pollyk@strategies360.com', password: 'apple'})
# @trial_client = client.fetch('getObjects.sjs', {object: 'Supporter'})
# SalsaLabs::Supporter.all
# @support = $client.fetch('getObjects.sjs', {object: 'Supporterw({email: email, password: passw'})
# client = SalsaLabs::ApiClient.new({email: 'anderson.emilyhi@gmail.com', password: '&erson813'})
# @support = client.fetch('getObjects.sjs', {object: 'Supporter'})
# RestClient.get 'https://sandbox.salsalabs.com/api/authenticate.sjs?xml&email=anderson.emilyhi@gmail.com&password=&erson813'
# @trial_client =  RestClient.get 'https://hq-salsa4.salsalabs.com/api/getObject.sjs?xml&object=supporter&key=62988113'
# @trial_client = RestClient.get 'https://sandbox.salsalabs.com/api/authenticate.sjs?xml&email=anderson.emilyhi@gmail.com&password=&erson813'
# @trial_client =  RestClient.get 'https://hq-salsa4.salsalabs.com/api/describe2.sjs?object=supporter'
# RestClient.get 'https://hq-salsa4.salsalabs.com/api/authenticate.sjs?&email=pollyk@strategies360.com&password=apple'
# @trial_client =  RestClient.get 'https://hq-salsa4.salsalabs.com/api/getObject.sjs?xml&object=supporter&key=62988113'
