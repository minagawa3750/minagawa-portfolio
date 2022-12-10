class TopController < ApplicationController
  def index
    @ranks = SkiResort.find(Review.group(:ski_resort_id).order('avg(rate) desc').limit(4).pluck(:ski_resort_id))
  end
end
