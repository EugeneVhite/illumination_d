FactoryGirl.define do
  factory :color do
    sequence(:name, 0) { |n| ['red', 'green', 'blue', 'black', 'gold'][n] }

    factory :color_with_products do
      transient do
        products_count 5
      end

      after(:create) do |color, evaluator|
        create_list(:product, evaluator.products_count, color: color)
      end
    end
  end

end
