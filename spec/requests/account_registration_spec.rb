require 'spec_helper'

describe "new account registration" do

  it 'should make non school e-mail a Viewer' do
    visit "/sign_up"
    fill_in "Email", :with => "test@nonschool.com"
    find("input[name='account[password]']").set("password")
    fill_in "Password confirmation", :with => "password"
    fill_in "First name", :with => "First"
    fill_in "Last name", :with => "Last"
    find("input[type='checkbox']").set(true)
    click_button "Sign Up"
    
    Account.find_by_email('test@nonschool.com').profile_type.should == 'Viewer'
  end

  it 'should make school e-mail a Contributor' do
    visit "/sign_up"
    fill_in "Email", :with => "test@uga.edu"
    find("input[name='account[password]']").set("password")
    fill_in "Password confirmation", :with => "password"
    fill_in "First name", :with => "First"
    fill_in "Last name", :with => "Last"
    find("input[type='checkbox']").set(true)
    click_button "Sign Up"
    
    Account.find_by_email('test@uga.edu').profile_type.should == 'Contributor'
  end

  it 'should create membership if you sign in with a invitation token' do
    invitation = FactoryGirl.create(:invitation)
    visit "/sign_up?invitation_token=#{invitation.invitation_token}"
    fill_in "Email", :with => "test@test.com"
    find("input[name='account[password]']").set("password")
    fill_in "Password confirmation", :with => "password"
    fill_in "First name", :with => "First"
    fill_in "Last name", :with => "Last"
    find("input[type='checkbox']").set(true)
    click_button "Sign Up"
    account = Account.find_by_email('test@test.com')
    account.confirm!
    
    visit "/sign_in"
    fill_in "Email", :with => account.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
   
    page.should have_content("Accept Invitation")
  end
end
