FactoryGirl.define do
  factory :user do
    name                  'Karel'
    email                 'karel@test.host'
    password              's3Cr3t.!'
    password_confirmation 's3Cr3t.!'
  end
end
