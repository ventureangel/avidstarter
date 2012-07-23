# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notificaiton do
    title "MyString"
    description "MyText"
    date "2012-07-23 13:49:34"
    priority? false
  end
end
