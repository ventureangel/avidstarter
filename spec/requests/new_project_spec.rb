require 'spec_helper'

describe "New Project" do
  let(:account) {FactoryGirl.create(:account)}

  it 'be able to create new project' do
    account.confirm!
    visit "/sign_in"
    fill_in "Email", :with => account.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
    click_link("Start A New Project")
    

    fill_in "Business name", :with => "My Test Project"
    select("Retail", :from => "Industry")
    fill_in "City", :with => 'Decatur'
    select("Georgia", :from => 'State')
    fill_in "Business concept", :with => "Make Money"

    click_button "Save Project"
    page.should have_content "Project successfully created"
    page.should have_content "My Test Project"
  end

end
