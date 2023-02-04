class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  def set_q
    @q = SkiResort.ransack(params[:q])
    @results = @q.result.page(params[:page])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image, :name])
  end
end
