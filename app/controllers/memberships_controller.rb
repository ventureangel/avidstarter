class MembershipsController < ApplicationController
  def create
    @membership = Membership.new(:project => Project.find(params[:membership][:project]))
    @account = Membership.check_if_user(params[:membership])
    @membership.account = @account
    if @membership.save
      flash[:notice] = "Member successfully added"
      redirect_to :back
    else
      flash[:warning] = "Member not added. Please try again."
      redirect_to :back
    end
  end
end
