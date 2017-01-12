require 'factory_girl'
FactoryGirl.define do
  factory :restaurant, class: Restaurant do
    initialize_with { new(params) }
  end

  trait :with_restaurant_a do
    params { {:name         => 'Restaurant A',
              :rating       => 5,
              :max_capacity => 30,
              :menu         => {:gluten_free => 1,
                                :nut_free    => 2
              }} }
  end

  trait :with_restaurant_b do
    params { {:name         => 'Restaurant B',
              :rating       => 3,
              :max_capacity => 30,
              :menu         => {:gluten_free => 5,
                                :nut_free    => 2
              }} }
  end
end