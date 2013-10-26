# encoding: UTF-8
FactoryGirl.define do
  factory :tag_technique do
    association :tag
    association :technique
  end
end
