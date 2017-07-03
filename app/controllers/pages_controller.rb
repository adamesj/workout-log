class PagesController < ApplicationController
  def homepage
  end

  def search
    @members = User.search_by_name(params[:search_name]).paginate(page: params[:page])
  end
end