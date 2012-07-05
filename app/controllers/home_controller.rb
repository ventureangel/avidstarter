class HomeController < ApplicationController
  def index
    flash[:notice] = "You Suck"
  end
end
