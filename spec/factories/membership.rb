FactoryGirl.define do
  factory :membership do
    association :account
    association :project
  end
end
