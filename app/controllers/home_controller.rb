class HomeController < ApplicationController

  def index
    render json: Tutor.all
  end

end