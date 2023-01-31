FactoryBot.define do
  factory :review do
    title { "review_title" }
    comment { "review_comment" }
    rate { 4.5 }
    association :user
    association :ski_resort
  end
end
