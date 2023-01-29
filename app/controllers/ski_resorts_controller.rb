class SkiResortsController < ApplicationController
  before_action :set_ski_resort, only: %i[show edit update destroy]
  before_action :admin_check, only: %i[index new edit update destroy]

  # GET /ski_resorts or /ski_resorts.json
  def index
    @ski_resorts = SkiResort.all
  end

  # GET /ski_resorts/1 or /ski_resorts/1.json
  def show
    @reviews = Review.where(ski_resort_id: params[:id])
  end

  # GET /ski_resorts/new
  def new
    @ski_resort = SkiResort.new
  end

  # GET /ski_resorts/1/edit
  def edit
  end

  # POST /ski_resorts or /ski_resorts.json
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

  # PATCH/PUT /ski_resorts/1 or /ski_resorts/1.json
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

  # DELETE /ski_resorts/1 or /ski_resorts/1.json
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

  # Use callbacks to share common setup or constraints between actions.
  def set_ski_resort
    @ski_resort = SkiResort.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
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
