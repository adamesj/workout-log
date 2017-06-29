class PagesController < ApplicationController
  def dashboard
    @members = User.paginate(page: params[:page], per_page: 5)
  end

  def homepage
  end

  def search
    @members = User.search_by_name(params[:search_name]).paginate(page: params[:page])
  end
end