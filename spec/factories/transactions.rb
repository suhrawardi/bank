# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    association :source, factory: :account
    association :destination, factory: :account
    status :failed
    msg 'something got wrong!'
  end
end
