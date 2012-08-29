# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competition do
    competition_name "Next Top Entrepreneur"
    time DateTime.now.utc
    city "Athens"
    state "Georgia"
    location "Sanford Hall"
    accepting_business_plans true
    prize "Pride"
    competition_details "Submit yo projects"
    requirements "Submit them!"
  end
end

