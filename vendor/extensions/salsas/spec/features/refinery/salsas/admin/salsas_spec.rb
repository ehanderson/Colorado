# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Salsas" do
    describe "Admin" do
      describe "salsas" do
        refinery_login_with :refinery_user

        describe "salsas list" do
          before do
            FactoryGirl.create(:salsa, :title => "UniqueTitleOne")
            FactoryGirl.create(:salsa, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.salsas_admin_salsas_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.salsas_admin_salsas_path

            click_link "Add New Salsa"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Salsas::Salsa.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Salsas::Salsa.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:salsa, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.salsas_admin_salsas_path

              click_link "Add New Salsa"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Salsas::Salsa.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:salsa, :title => "A title") }

          it "should succeed" do
            visit refinery.salsas_admin_salsas_path

            within ".actions" do
              click_link "Edit this salsa"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:salsa, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.salsas_admin_salsas_path

            click_link "Remove this salsa forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Salsas::Salsa.count.should == 0
          end
        end

      end
    end
  end
end
