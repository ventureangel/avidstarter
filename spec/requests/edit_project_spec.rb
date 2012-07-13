require 'spec_helper'

describe "Edit Project" do
  let(:account) {FactoryGirl.create(:account)}
  let(:mail) {stub(deliver: true)}
  let(:existing_account) {FactoryGirl.create(:account, :email => 'exist@uga.edu')}
  before { 
    account.confirm!
    existing_account.confirm!    
    visit "/sign_in"
    fill_in "Email", :with => account.email
    fill_in "Password", :with => 'password'
    click_button "Sign In"
    @project = FactoryGirl.create(:project) 
    @project.save
    @membership = Membership.new(project: @project, account: account)
    @membership.save
    visit edit_project_path(@project)
    ActionMailer::Base.deliveries = []
  }
  it 'should be able to edit project' do
    fill_in 'Business name', :with => 'Hamburger!'
    click_button "Save Project"
    page.should have_content "Project successfully updated"
  end

  it 'should send email when inviting new account' do
    fill_in "Name", :with => "Tester"
    find("input[name='membership[email]']").set("test@test.com")
    #ProjectMembers.should_receive(:new_user_membership_invitation).and_return(mail)
    click_button "Add New Team Member"
    ActionMailer::Base.deliveries.should_not be []
  end

  it 'should call membership invitation and send email when inviting current account' do
    
    fill_in "Name", :with => "Current User"
    find("input[name='membership[email]']").set(existing_account.email)
    #ProjectMembers.should_receive(:membership_invitation).and_return(mail)
    click_button "Add New Team Member"
    ActionMailer::Base.deliveries.should_not be []
  end
end
