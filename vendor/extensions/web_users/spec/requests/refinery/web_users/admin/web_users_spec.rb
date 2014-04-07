# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "WebUsers" do
    describe "Admin" do
      describe "web_users" do
        login_refinery_user

        describe "web_users list" do
          before do
            FactoryGirl.create(:web_user, :role => "UniqueTitleOne")
            FactoryGirl.create(:web_user, :role => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.web_users_admin_web_users_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.web_users_admin_web_users_path

            click_link "Add New Web User"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Role", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::WebUsers::WebUser.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Role can't be blank")
              Refinery::WebUsers::WebUser.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:web_user, :role => "UniqueTitle") }

            it "should fail" do
              visit refinery.web_users_admin_web_users_path

              click_link "Add New Web User"

              fill_in "Role", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::WebUsers::WebUser.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:web_user, :role => "A role") }

          it "should succeed" do
            visit refinery.web_users_admin_web_users_path

            within ".actions" do
              click_link "Edit this web user"
            end

            fill_in "Role", :with => "A different role"
            click_button "Save"

            page.should have_content("'A different role' was successfully updated.")
            page.should have_no_content("A role")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:web_user, :role => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.web_users_admin_web_users_path

            click_link "Remove this web user forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::WebUsers::WebUser.count.should == 0
          end
        end

      end
    end
  end
end
