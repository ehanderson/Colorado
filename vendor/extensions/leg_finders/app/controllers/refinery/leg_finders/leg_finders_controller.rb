module Refinery
  module LegFinders
    class LegFindersController < ::ApplicationController

      before_filter :find_page, :only => [:create, :new]

      def index
        redirect_to :action => "new"
      end

      def thank_you
        p $members_of_congress
        p $district
        @page = Refinery::Page.find_by_link_url("/leg_finders/thank_you", :include => [:parts])
      end

      def new
        @leg_finder = LegFinder.new
      end

      def create
  sunlight = 'http://assets.sunlightfoundation.com/moc/200x250.zip'



## Step A. Download a zip file of images from Sunlight:

zip_basename = File.basename(sunlight, '.zip')

unless File.directory?(zip_basename)
  puts "Downloading #{sunlight}...this may take awhile..."
  File.open("#{zip_basename}.zip", 'w'){|f| f.write( RestClient.get(URLS['sunlight']) ) }

## Use the backtick to call your systems' unzip program...hopefully you have
## 'unzip' somewhere. Otherwise, unzip the folder manually and just skip this step:

  `unzip #{zip_basename}.zip`

## a directory named [zip_basename] should appear in your working directory
## this contains all the image files
end

        $members_of_congress = Sunlight::Legislator.all_in_zipcode(params[:leg_finder][:zip])
        $district = Sunlight::District.all_from_zipcode(params[:leg_finder][:zip])
        p $district
        if $members_of_congress.empty?
          @leg_finder = LegFinder.new($members_of_congress)
        else
          @leg_finder = LegFinder.new(params[:leg_finder])
        end

        if @leg_finder.save
          begin
            Mailer.notification(@leg_finder, request).deliver
          rescue => e
            logger.warn "There was an error delivering the leg_finder notification.\n#{e.message}\n"
          end

          redirect_to refinery.thank_you_leg_finders_leg_finders_path
        else
          render :action => 'new'
        end
      end

    protected

      def find_page
        @page = Refinery::Page.find_by_link_url('/leg_finders/new', :include => [:parts])
      end

    end
  end
end
