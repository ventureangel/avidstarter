class HomeController < ApplicationController
  def home
    @projects = current_account.projects
  end
end
