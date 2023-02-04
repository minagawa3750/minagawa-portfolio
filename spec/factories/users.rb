FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
    after(:build) do |user|
      user.image.attach(io: File.open('spec/fixtures/user_test.jpeg'), filename: 'user_test.jpeg', content_type: 'image/jpeg')
    end

    trait :admin do
      admin { true }
    end

    trait :guest do
      id { 3 } 
    end
  end
end
