$client = SalsaLabs::ApiClient.new do |config|
  config.salsa_labs_api_email        = ENV["SALSA_LABS_API_EMAIL"]
  config.salsa_labs_api_password     = ENV["SALSA_LABS_API_PASSWORD"]
end
# $client = SalsaLabs::ApiClient.new({email: 'anderson.emilyhi@gmail.com', password: '&erson813'})
# https://sandbox.salsalabs.com/api/authenticate.sjs?email=andrson.emilyhi@gmail.com&password=&erson813

