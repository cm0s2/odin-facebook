class UsersController < ApplicationController
  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
  end
end
