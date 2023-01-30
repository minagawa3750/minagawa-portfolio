class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new]
  before_action :ensure_user, only: %i[edit update destroy]

  # GET /reviews or /reviews.json
  def index
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @ski_resort = SkiResort.find(params[:ski_resort_id])
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @ski_resort = SkiResort.find(params[:ski_resort_id])

    respond_to do |format|
      if @review.save
        format.html { redirect_to ski_resort_path(@ski_resort), notice: "レビューを投稿しました。" }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to ski_resort_review_path(@review.ski_resort_id, @review.id), notice: "レビューを更新しました。" }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to ski_resort_path(@ski_resort), notice: "レビューを削除しました。" }
      format.json { head :no_content }
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
    @ski_resort = SkiResort.find(params[:ski_resort_id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:user_id, :ski_resort_id, :title, :comment, :rate)
  end

  def ensure_user
    if @review.user != current_user
      redirect_to ski_resort_path(@review.ski_resort_id)
      flash[:alert] = "このページは閲覧できません。"
    end
  end
end
