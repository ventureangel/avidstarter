require 'spec_helper'

describe "Sign_In" do
  let(:account) {FactoryGirl.create(:account)}

  it 'should sign in' do
    account.confirm!
    visit "/sign_in"
    fill_in "Email", :with => account.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
   
    page.should have_content("Signed in successfully")
  end

  it 'should require you to confirm before signing in' do
    visit "/sign_in"
    fill_in "Email", :with => account.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
    
    page.should have_content("You have to confirm your account before continuing")
  end
end

