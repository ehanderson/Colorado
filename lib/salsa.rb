class EmailBlast
  attr_reader :email, :password, :host, :authenticated

  def initialize(credentials = {})
    @email = credentials[:email]
    @password = credentials[:password]

    @host = "https://hq-salsa4.salsalabs.com/"

    @authenticated = authenticate! 
  end

  def authenticate!
    response = RestClient.get("api/authenticate.sjs?&email=#{@email}.com&password=#{@password}")
  end

end