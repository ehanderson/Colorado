require 'spec_helper'

module Refinery
  module SocialMediaPosts
    describe SocialMediaPost do
      describe "validations" do
        subject do
          FactoryGirl.create(:social_media_post)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
