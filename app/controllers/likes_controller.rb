class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, ski_resort_id: params[:ski_resort_id])
    @like.save
    redirect_to ski_resort_path(params[:ski_resort_id])
    flash[:notice] = "いいねしました。"
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, ski_resort_id: params[:ski_resort_id])
    @like.destroy
    redirect_to ski_resort_path(params[:ski_resort_id])
    flash[:notice] = "いいねをはずしました。"
  end
end
