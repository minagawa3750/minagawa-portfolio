FactoryBot.define do
  factory :like do
    association :user
    association :ski_resort
  end
end
