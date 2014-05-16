# # # authenticated response

response = RestClient.get "https://hq-salsa4.salsalabs.com/api/authenticate.sjs?&email=#{ENV["SALSA_LABS_API_EMAIL"]}.com&password=#{ENV["SALSA_LABS_API_PASSWORD"]}"
cookie = response.cookies
t = RestClient.get("https://hq-salsa4.salsalabs.com/api/getObjects.sjs?xml&object=email_blast",
                cookies: cookie
              )
w = Hash.from_xml(t).to_json
parsed_response = JSON.parse(w)
blasts = parsed_response['data']['email_blast']['item'].reverse
$all_blasts = []

blasts.each do |blast|
 $all_blasts << blast if blast['Display_To_User'] == "true"
end
