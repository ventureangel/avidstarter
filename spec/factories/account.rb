FactoryGirl.define do
  factory :account do
    sequence(:email) { |i| "test#{i}@uga.edu" }
    first_name 'Cubert'
    last_name 'Farnsworth'
    password 'password'
    password_confirmation 'password'
    
    factory :viewer do
      sequence(:email) { |i| "test#{i}@nonschool.com" }
    end
    factory :invited_contributor do
      invitation_token "token"
    end
  end
end
