class UsersController < ApplicationController
  before_action :set_user, only: [:likes]

  def likes
    @likes = Like.where(user_id: @user.id).pluck(:ski_resort_id)
    @like_resort = SkiResort.find(@likes)
  end
    
  private
    def set_user
      @user = User.find(params[:id])
    end
end
