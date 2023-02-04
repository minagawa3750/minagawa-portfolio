class SkiResortsController < ApplicationController
  before_action :set_ski_resort, only: %i[show edit update destroy]
  before_action :admin_check, only: %i[index new edit update destroy]

  def index
    @ski_resorts = SkiResort.all.page(params[:page]).per(10)
  end

  def show
    @reviews = Kaminari.paginate_array(Review.where(ski_resort_id: params[:id]).order(id: 'desc')).page(params[:page]).per(5)
  end

  def new
    @ski_resort = SkiResort.new
  end

  def edit
  end

  def create
    @ski_resort = SkiResort.new(ski_resort_params)

    respond_to do |format|
      if @ski_resort.save
        format.html { redirect_to ski_resorts_path, notice: "ゲレンデの情報を登録しました。" }
        format.json { render :show, status: :created, location: @ski_resort }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ski_resort.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ski_resort.update(ski_resort_params)
        format.html { redirect_to ski_resort_path(@ski_resort), notice: "ゲレンデの情報を更新しました。" }
        format.json { render :show, status: :ok, location: @ski_resort }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ski_resort.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ski_resort.destroy

    respond_to do |format|
      format.html { redirect_to ski_resorts_path, notice: "ゲレンデの情報を削除しました。" }
      format.json { head :no_content }
    end
  end

  def search
  end

  private

  def set_ski_resort
    @ski_resort = SkiResort.find(params[:id])
  end

  def ski_resort_params
    params.require(:ski_resort).permit(:resort_image, :resort_name, :address, :longitude, :latitude, :hp_url, :phone_number, :start_time, :end_time, :start_day, :end_day, :business_remarks, :resort_feature, :ski_lift, :courses, :maximum_tilt, :maximum_distance, :image, :adult_price, :kid_price, :senior_price, :introduction)
  end

  def admin_check
    if current_user.admin == false
      redirect_to root_path
      flash[:alert] = "このページは閲覧できません。"
    end
  end
end
