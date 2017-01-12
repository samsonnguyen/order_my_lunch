require 'factory_girl'

FactoryGirl.define do
  factory :restaurant, class: Restaurant do
    initialize_with { new(params) }

    trait :with_restaurant_a do
      params { {:name         => 'Restaurant A',
                :rating       => 5,
                :max_capacity => 30,
                :menu         => {:gluten_free => 1,
                                  :nut_free    => 2,
                                  :vegetarian  => 5
                }} }
    end

    trait :with_restaurant_b do
      params { {:name         => 'Restaurant B',
                :rating       => 3,
                :max_capacity => 30,
                :menu         => {:gluten_free => 5,
                                  :nut_free    => 2,
                                  :vegetarian  => 5
                }} }
    end
  end

  factory :order_my_lunch, class: OrderMyLunch do
    initialize_with { new(params) }
    params { {:restaurant_list    => [{:name         => 'Restaurant A',
                                       :rating       => 3,
                                       :max_capacity => 30,
                                       :menu         => {:gluten_free => 5,
                                                         :nut_free    => 2,
                                                         :vegetarian  => 5,
                                                         :fish_free   => 1
                                       }},
                                      {:name         => 'Restaurant B',
                                       :rating       => 5,
                                       :max_capacity => 30,
                                       :menu         => {:gluten_free => 1,
                                                         :nut_free    => 2,
                                                         :vegetarian  => 5
                                       }}],
              :allow_alternatives => true
    } }

    trait :with_substitutions do
      allow_alternatives true
    end

    trait :without_substitutions do
      allow_alternatives false
    end
  end


end