FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "testEmail#{n}@email.com" }
    fio 'Test User'
    password 'testPass1'
    password_confirmation 'testPass1'
  end

  factory :event do
    sequence(:name) { |n| "TestEvent#{n}" }
    start_date Date.tomorrow
    user
  end
end