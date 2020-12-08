class ReviewUsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    raise
  end
end
