class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests.includes(:friend)
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      # render :show, status: :created, location: @friend_request
      redirect_to user_path(friend)
    else
      #@friend_request.errors.each { |error| p error }
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def update
    @friend_request.accept
    redirect_back fallback_location: friend_requests_path
  end

  def destroy
    friend = @friend_request.friend
    @friend_request.destroy

    redirect_back fallback_location: friend_requests_path
    # head :no_content
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

end
