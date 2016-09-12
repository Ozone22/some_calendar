FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "testEmail#{n}@email.com" }
    fio 'Test User'
    password 'testPass1'
    password_confirmation 'testPass1'
  end
end