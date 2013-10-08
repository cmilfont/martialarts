FactoryGirl.define do
  factory :user do
    name "Christiano Milfont"
    sequence(:email) { |n| "usern_#{n}@user.com"}
    password "147/258*369"
  end
end