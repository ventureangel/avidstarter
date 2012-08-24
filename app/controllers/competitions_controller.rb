class CompetitionsController < ApplicationController
  def new
    @competition = Competition.new
  end
end
