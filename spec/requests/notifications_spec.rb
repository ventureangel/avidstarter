require 'spec_helper'

describe 'New Notification' do
  let(:account) {FactoryGirl.create(:account, :email => 'exist@uga.edu')}
  before { 
    account.confirm!
    visit "/sign_in"
    fill_in "Email", :with => account.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
    #@project = FactoryGirl.create(:project) 
    #@project.save
    #@membership = Membership.new(project: @project, account: account, pending: false)
    #@membership.save
    #visit edit_project_path(@project)
    ActionMailer::Base.deliveries = []
  }
  it 'should be createable by an account' do
    visit new_notification_path
    find("input[name='notification[title]']").set("We need a hero!")
    select("Recruiting", :from => "Type")
    find("textarea[name='notification[description]']").set("We need a hero immediately")
    click_button 'Post Notification'

    page.should have_content 'Recruiting notification successfully posted'
  end



end

describe 'Edit Notification' do 
  pending
end
