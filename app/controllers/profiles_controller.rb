class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ edit update ]

  def edit
  end

  def update
    if @profile.update(profile_params)
      puts "help"
      redirect_to user_path(current_user), notice: "Post was successfully updated."
    else
      puts "help"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :description)
  end
end
