module Refinery
  module LegislatorLookups
    class LegislatorLookupsController < ::ApplicationController

      before_filter :find_page, :only => [:create, :new]

      def index
        redirect_to :action => "new"
      end

      def thank_you
        # @auth = RestClient.get'https://hq-salsa4.salsalabs.com/api/authenticate.sjs?json&email=pollyk@strategies360.com&password=apple';
        # email = RestClient.get('https://hq-salsa4.salsalabs.com/api/getObject.sjs?xml&object=supporter&key=62988113');
        # @emails = JSON.parse(email)
        ################ DO NOT DELETE THE FOLLOWING LINES ###############################
        # current_district = $members_of_congress.last.district
        # district = RestClient.get 'openstates.org/api/v1//legislators/?state=il&chamber=upper&active=true&apikey=d6c3a81da4e74c6c8d9983a6dd258f7e'
        # lower = RestClient.get "openstates.org/api/v1//legislators/?state=il&chamber=lower&active=true&apikey=d6c3a81da4e74c6c8d9983a6dd258f7e"
        # @people = JSON.parse(district)
        @page = Refinery::Page.find_by_link_url("/legislator_lookups/thank_you", :include => [:parts])
      end

      def new
        @legislator_lookup = LegislatorLookup.new
      end

      def create
        $members_of_congress = Sunlight::Legislator.all_in_zipcode(params[:legislator_lookup][:zipcode])
        if $members_of_congress.empty?
          @legislator_lookup = LegislatorLookup.new($members_of_congress)
        else
          @legislator_lookup = LegislatorLookup.new(params[:legislator_lookup])
        end

        if @legislator_lookup.save
          begin
            Mailer.notification(@legislator_lookup, request).deliver
          rescue => e
            logger.warn "There was an error delivering the legislator_lookup notification.\n#{e.message}\n"
          end

          redirect_to refinery.thank_you_legislator_lookups_legislator_lookups_path
        else
          render :action => 'new'
        end
      end

    protected

      def find_page
        @page = Refinery::Page.find_by_link_url('/legislator_lookups/new', :include => [:parts])
      end

    end
  end
end
