# # # authenticated response

response = RestClient.get "https://hq-salsa4.salsalabs.com/api/authenticate.sjs?&email=#{ENV["SALSA_LABS_API_EMAIL"]}.com&password=#{ENV["SALSA_LABS_API_PASSWORD"]}"
cookie = response.cookies
xml_response = RestClient.get("https://hq-salsa4.salsalabs.com/api/getObjects.sjs?xml&object=email_blast",
                cookies: cookie
              )


# # # receive xml, convert to json and parse
json_response = Hash.from_xml(xml_response).to_json
parsed_response = JSON.parse(json_response)

blasts = parsed_response['data']['email_blast']['item'].reverse
$all_blasts = []

blasts.each do |blast|
 $all_blasts << blast if blast['Display_To_User'] == "true"
end
