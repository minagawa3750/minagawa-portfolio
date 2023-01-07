class UsersController < ApplicationController
  before_action :set_user, only: [:interests]

  def interests
    @interests = Interest.where(user_id: @user.id).pluck(:ski_resort_id)
    @interest_resort = SkiResort.find(@interests)
  end
    
  private
    def set_user
      @user = User.find(params[:id])
    end
end
