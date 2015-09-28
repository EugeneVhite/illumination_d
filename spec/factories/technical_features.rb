FactoryGirl.define do
  factory :technical_feature do
    product
    cap_type "what's that?"
    lamp_type "lighting lamp"
    height "20.9"
    width "4.92"
    length "114.8"
    diameter "9.99"
    amount_of_lamps 2
    illum_area "9.99"
    total_power "14"
    one_lamp_power "7"

    factory :technical_feature_with_wrong_power do
      total_power "7.8"
      one_lamp_power "8.5"
    end

    factory :technical_feature_with_correct_power do
      total_power "15.6"
      one_lamp_power "7.8"
    end

    factory :technical_feature_without_power_arguments do
      amount_of_lamps nil
      one_lamp_power nil
      total_power nil
    end
  end

end
