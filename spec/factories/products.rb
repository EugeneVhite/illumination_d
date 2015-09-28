FactoryGirl.define do
  factory :product do
    name { |n| "ultimate#{n}" }
    description "a thing you realy want"
    price "9.99"
    article_number "AE-123523"
    remote false

    factory :product_for_color do
      color
    end

    factory :product_for_type do
      type
    end

    factory :product_for_manufacturer do
      manufacturer
    end

    factory :product_for_style do
      style
    end
  end

end
