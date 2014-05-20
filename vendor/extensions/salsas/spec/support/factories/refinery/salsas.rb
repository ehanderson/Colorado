
FactoryGirl.define do
  factory :salsa, :class => Refinery::Salsas::Salsa do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

