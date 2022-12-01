FactoryBot.define do
  factory :review do
    user_id { 1 }
    ski_resort_id { 1 }
    title { "MyString" }
    comment { "MyText" }
    rate { 1.5 }
  end
end
