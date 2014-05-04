require_relative '../lib/facebook'
require 'pry'

describe "Facebook" do
  describe '#renew_long_lived_access_token' do
    Facebook_Page = Struct.new(:name, :access_token)

    it 'returns a token' do
      short_user_token = ENV["ACCESS_TOKEN"] # THIS EXPIRES IN TWO HOURS

      medium_token = double("medium_token", access_token: "abc123")
      api_double   = double('facebook_api')
      page_double  = Facebook_Page.new("facebook pages", "never_expiring_token")

      Koala::Facebook::OAuth.any_instance.stub_chain(:exchange_access_token_info, :[]).and_return(medium_token)
      Koala::Facebook::API.stub(:new).and_return(api_double)
      api_double.stub(:get_connections).and_return([page_double])

      expect(renew_long_lived_access_token(short_user_token)).to eq("never_expiring_token")
    end
  end

  describe '#save_page_token' do
    it 'saves the token to the database' do
      
    end
  end

end