require 'spec_helper'

describe "New Competition" do

  let(:account) {FactoryGirl.create(:admin)}
  before { 
    account.confirm!
    visit "/sign_in"
    fill_in "Email", :with => account.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
    visit new_competition_path
  }

  it 'should be able to create a new competition' do
    fill_in "Competition name", :with => "Next Top Entrepreneur"
    find("input[name='competition[date]']").set("2012-09-12")
    find("input[name='competition[time]']").set("16:00:00")
    fill_in "City", :with => "Athens"
    select("Georgia", :from => "State")
    fill_in "Location", :with => "Sanford Hall"

    fill_in "Prize", :with => "Pride"
    fill_in "Competition Details", :with => "Submit yo projects"
    fill_in "Competition Requirements", :with => "Submit them!"
    click_button "Save Competition"
    page.should have_content "Competition successfully created"
  end

end
