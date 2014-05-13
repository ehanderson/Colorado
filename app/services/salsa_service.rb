class SalsaRequest    
    def salsa
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
      RestClient.get 'https://hq-salsa4.salsalabs.com/api/authenticate.sjs?xml&email=pollyk@strategies360.com&password=apple'
      @trial_client =  RestClient.get 'https://hq-salsa4.salsalabs.com/api/getObject.sjs?xml&object=supporter&key=62988113'
    end

end
