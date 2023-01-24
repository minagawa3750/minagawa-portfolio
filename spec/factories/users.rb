FactoryBot.define do
  factory :user do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/user_test.jpeg"))}
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "test#{n}@example.com"}
    password{ "password" }
    password_confirmation{ "password"}
    admin{ false }

    trait :admin do
      sequence(:email) { |n| "test#{n}@example.com"}
      admin{ true }
    end
  end
end
