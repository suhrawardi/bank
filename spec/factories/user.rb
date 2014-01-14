FactoryGirl.define do
  factory :user do
    sequence(:name)       { |n| "user#{n}" }
    sequence(:email)      { |n| "email#{n}@text.host" }
    password              's3Cr3t.!'
    password_confirmation 's3Cr3t.!'
  end
end
