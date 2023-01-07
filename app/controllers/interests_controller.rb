class InterestsController < ApplicationController
  def create
    @interest = Interest.new(user_id: current_user.id, ski_resort_id: params[:ski_resort_id])
    @interest.save
    redirect_to ski_resort_path(params[:ski_resort_id])
    flash[:notice] = "気になるリストに追加しました。"
  end

  def destroy
    @interest = Interest.find_by(user_id: current_user.id, ski_resort_id: params[:ski_resort_id])
    @interest.destroy
    redirect_to ski_resort_path(params[:ski_resort_id])
  end
end
