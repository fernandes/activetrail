FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password "password"
    password_confirmation "password"
  end
  
  factory :admin, class: "User" do
    sequence :email do |n|
      "admin#{n}@example.com"
    end
    password "password"
    password_confirmation "password"
    admin true
  end
end
