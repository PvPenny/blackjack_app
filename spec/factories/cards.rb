FactoryGirl.define do
  factory :card do
    sequence(:name){|i|"#{i}"}
    sequence(:cost){|i|"#{i}"}
  end
end