require 'spec_helper'

describe 'Admin' do
  let(:admin) {FactoryGirl.create(:admin)}

  before {
    admin.profile_type = 'Admin'
    admin.confirm!
    visit "/sign_in"
    fill_in "Email", :with => admin.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
  }

  it 'should be able to delete projects it is not a member of' do
    pending 
  end

  it 'should be able to delete notifications it did not make' do
    pending
  end
end
