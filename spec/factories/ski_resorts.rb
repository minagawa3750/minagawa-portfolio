FactoryBot.define do
  factory :ski_resort do
    resort_name { "resort_name" }
    address { "栃木県那須塩原市湯本塩原字前黒" }     
    phone_number { "123-456-789" }
    start_day { "2023-01-01" }
    end_day { "2023-03-31" }
    start_time { "09:00"}
    end_time { "16:00" }
    business_remarks { "営業時間変動あり" }
    adult_price { "¥5,000" }
    kid_price { "¥4,000" }
    senior_price { "¥3,000" }
    ski_lift { 1 }
    courses { 2 }
    maximum_tilt { 3 }
    maximum_distance { 4 }
    resort_feature { "初心者におすすめ" }
    introduction { "レンタル用品が充実" }
    hp_url { "https://www.mtjeans.com/winter/" }
    after(:build) do |ski_resort|
      ski_resort.resort_image.attach(io: File.open('spec/fixtures/test.jpeg'), filename: 'test.jpeg', content_type: 'image/jpeg')
    end
  end
end