$client = SalsaLabs::ApiClient.new do |config|
  config.salsa_labs_api_email        = ENV["SALSA_LABS_API_EMAIL"]
  config.salsa_labs_api_password     = ENV["SALSA_LABS_API_PASSWORD"]
end
