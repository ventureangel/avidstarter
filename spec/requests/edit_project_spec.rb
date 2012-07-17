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
    @membership = Membership.new(project: @project, account: account, pending: false)
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
    click_button "Add New Team Member"
    ActionMailer::Base.deliveries.should_not be []
  end

  it 'should call membership invitation and send email when inviting current account' do
    
    fill_in "Name", :with => "Current User"
    find("input[name='membership[email]']").set(existing_account.email)
    click_button "Add New Team Member"
    ActionMailer::Base.deliveries.should_not be []
  end

  it 'should be able to upload a logo' do #CHANGE THIS. IT ACTUALLY LOADS TO AWS
    #find("input[name='project[logo]']").set("/home/squizzleflip/Pictures/glados.jpg")
    #click_button "Save Project" 
    #page.should have_content "Project successfully updated"
    pending
  end

  it 'should be able to upload a business plan' do
    #find("input[name='project[business_plan]']").set("/home/squizzleflip/Downloads/f1120sg.pdf")
    #click_button "Save Project"
    #page.should have_content "Project successfully updated"
    pending
  end

  it 'should only allow pdf, docx and doc business plans' do 
    #find("input[name='project[business_plan]']").set("/home/squizzleflip/Pictures/glados.jpg")
    #click_button "Save Project"
    #page.should have_content "Business plan You are not allowed to upload \"jpg\" files, allowed types: [\"doc\", \"docx\", \"pdf\"]"
    pending
  end

  it 'should be able to upload attachments' do
    #find("input[name='attachment[file]']").set("/home/squizzleflip/Pictures/glados.jpg")
    #click_button "Upload Attachment"
    #page.should have_content "Attachment successfully uploaded"
    pending
  end

end