FactoryGirl.define do
  factory :video do
    link "http://www.youtube.com/embed/IIWyg-5e87w?html5=1"
    association :technique
  end
end