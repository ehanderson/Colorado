OAUTH = FacebookService.connect_to_oauth

GRAPH = FacebookService.connect_to_graph(ENV["ACCESS_TOKEN"])

PAGES = FacebookService.get_managed_pages

PAGE_TOKEN = PAGES.first['access_token'] # THIS EXPIRES IN TWO HOURS

NEW_ACCESS_TOKEN = FacebookService.extend_access_token_expiration(PAGE_TOKEN) # THIS EXPIRES IN 2 MONTHS

LONG_ACCESS_TOKEN = NEW_ACCESS_TOKEN['access_token']
EXPIRATION        = NEW_ACCESS_TOKEN['expires']

# binding.pry

# Alternative Route
# -----------------
# Store the long-term token to a fb_account model.
# Use long-term token for 2 months
# Set up cron job to refresh token every 2 months
# Cron jobs for status updates every ~3 hours using long-term token

# RestClient.post("https://graph.facebook.com/oauth/access_token?client_id=#{ENV["APP_ID"]}&client_secret=#{ENV["APP_SECRET"]}&grant_type=fb_exchange_token&fb_exchange_token=#{LONG_ACCESS_TOKEN['access_token']}", {})
# if we want more transparency into url vs. koala wrapper we can use restcient

### ================== RESOURCES ============================= ###

# Koala Page Documentation
# https://github.com/arsduo/koala/wiki/Acting-as-a-Page

# Debugger
# https://developers.facebook.com/tools/explorer
# DEBUG / SEE EXPIRATION HERE: https://developers.facebook.com/tools/debug/

# Facebook Docs
# https://developers.facebook.com/docs/facebook-login/access-tokens/
# https://developers.facebook.com/docs/roadmap/completed-changes/offline-access-removal/ (scenario 5)

# Stack Overflow Step by Step (poor)
# http://stackoverflow.com/questions/12168452/long-lasting-fb-access-token-for-server-to-pull-fb-page-info?lq=1

# Get 2 Month Access Token with Koala: 
# https://github.com/mkdynamic/omniauth-facebook/issues/23#issuecomment-15565902

### =================== STEP BY STEP ========================== ###

# 1) Create page (different from user timeline)
# 2) Generate access token and click 'manage pages' in extended permissions
# 3) Connect to ::Oauth and ::API via koala (can do in rails console / pry)
#    - OAUTH = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV["APP_SECRET"])
#    - GRAPH = Koala::Facebook::API.new(ENV['ACCESS_TOKEN']) -> via graph explorer online
# 3) Get managed pages via
#    - GRAPH.get_connections('me', 'accounts')
# 4) Get the token of the specific page the account manages 
#    - PAGE_TOKEN = PAGES.first['access_token'] 
# 5) Exchange the short-lived token for a long-lived token via:
#    - LONG_ACCESS_TOKEN = OAUTH.exchange_access_token_info(PAGE_TOKEN)
# 6) Use the long-lived access token to make a request and retrieve never expiring token
#    - NEED TO FIGURE THIS OUT

### ============= PAGE API (Same as reg user) ================== ###

# @page_graph = Koala::Facebook::API.new(page_token)

# @page_graph.get_object('me') # I'm a page
# @page_graph.get_connection('me', 'feed') # the page's wall
# @page_graph.get_connections('me', 'statuses')
# @page_graph.put_wall_post('post on page wall') # post as page, requires publish_stream permission
# @page_graph.put_connections(page_id, 'feed', :message => message, :picture => picture_url, :link => link_url)