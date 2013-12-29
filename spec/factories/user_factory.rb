FactoryGirl.define do
  factory :user, class: Subscribem::User do
    sequence(:email) { "test#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end
end
