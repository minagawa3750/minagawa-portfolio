FactoryBot.define do
  factory :ski_resort do
    resort_image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test.jpeg"))}
    resort_name { "resort_name" }
    address { "栃木県那須塩原市湯本塩原字前黒" }     
    phone_number { "123-456-789" }
    start_day { "2023-01-01" }
    end_day { "2023-03-31" }
    start_time { "09:00"}
    end_time { "16:00" }
    business_remarks { "営業時間変動あり" }
    adult_price { "adult_price" }
    kid_price { "kid_price" }
    senior_price { "senior_price" }
    ski_lift { 1 }
    courses { 2 }
    maximum_tilt { 3 }
    maximum_distance { 4 }
    resort_feature { "特徴" }
    introduction { "おすすめ" }
    hp_url { "hp_url" }
  end
end