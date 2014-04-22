short_user_token = ENV["ACCESS_TOKEN"] # THIS EXPIRES IN TWO HOURS

oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV["APP_SECRET"])

long_user_token = oauth.exchange_access_token_info(short_user_token) # THIS EXPIRES IN 2 MONTHS

PAGES = FacebookService.get_managed_pages(long_user_token["access_token"])

LONG_PAGE_TOKEN = PAGES.first['access_token'] # This expires NEVER!!! Wahoooo

### ================== RESOURCES ============================= ###

# Extending Page Access Tokens
# *** https://developers.facebook.com/docs/facebook-login/access-tokens/#extending
# *** http://rubydoc.info/github/arsduo/koala/Koala/Facebook/OAuth

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
# 3) Connect to ::Oauth via koala (can do in rails console / pry)
#    - OAUTH = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV["APP_SECRET"])
# 4) Exchange short-term USER access_token for long-term USER access_token
#    - long_token = OAUTH.exchange_access_token_info(ENV['ACCESS_TOKEN']) #ENV has short_token
# 5) Use that long-term token to access the user's managed pages
#    - GRAPH = Koala::Facebook::API.new(long_token)
# 6) Get the token of the specific page the account manages 
#    - pages = GRAPH.get_connections('me', 'accounts')
#    - never_expire_token = pages.first["access_token"]

### ============= PAGE API (Same as regular user) ================== ###

# @page_graph = Koala::Facebook::API.new(page_token)

# @page_graph.get_object('me') # I'm a page
# @page_graph.get_connection('me', 'feed') # the page's wall
# @page_graph.get_connections('me', 'statuses')
# @page_graph.put_wall_post('post on page wall') # post as page, requires publish_stream permission
# @page_graph.put_connections(page_id, 'feed', :message => message, :picture => picture_url, :link => link_url)