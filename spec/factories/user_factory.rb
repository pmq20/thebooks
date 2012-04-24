# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "foo#{n}@bar.com"}
    name '王致和'
    password 'really_really_dark'
  end
end
