require 'spec_helper'

module Refinery
  module WebUsers
    describe WebUser do
      describe "validations" do
        subject do
          FactoryGirl.create(:web_user,
          :role => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:role) { should == "Refinery CMS" }
      end
    end
  end
end
