
FactoryGirl.define do
  factory :web_user, :class => Refinery::WebUsers::WebUser do
    sequence(:role) { |n| "refinery#{n}" }
  end
end

