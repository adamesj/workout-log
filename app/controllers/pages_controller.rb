class PagesController < ApplicationController
  def dashboard
    @members = User.paginate(page: params[:page], per_page: 5)
  end

  def homepage
  end
end