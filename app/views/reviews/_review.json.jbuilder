json.extract! review, :id, :user_id, :ski_resort_id, :title, :comment, :rate, :created_at, :updated_at
json.url review_url(review, format: :json)
