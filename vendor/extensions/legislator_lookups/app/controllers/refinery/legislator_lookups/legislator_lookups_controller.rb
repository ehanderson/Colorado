module Refinery
  module LegislatorLookups
    class LegislatorLookupsController < ::ApplicationController

      before_filter :find_page, :only => [:create, :new]

      def index
        redirect_to :action => "new"
      end

      def thank_you
        p $members_of_congress
        # $district
        @page = Refinery::Page.find_by_link_url("/legislator_lookups/thank_you", :include => [:parts])
      end

      def new
        @legislator_lookup = LegislatorLookup.new
      end

      def create
        $members_of_congress = Sunlight::Legislator.all_in_zipcode(params[:legislator_lookup][:zipcode])
        # Sunlight::Committee.all_for_chamber("Senate")
        p $members_of_congress
        # $district = GovKit::OpenStates::State.find_by_abbreviation('CO')
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
