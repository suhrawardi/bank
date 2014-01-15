# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    association :source, factory: :account
    association :destination, factory: :account
    status :danger
    msg 'something got wrong!'
    created_at Time.now
  end
end
