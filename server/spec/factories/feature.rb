FactoryBot.define do 
  factory :width, class: Feature do
    feature_type { Feature.feature_types[:float] }
    association :product, factory: :plastic_carrier_bag
    association :feature_label, factory: :width_label
  end

  factory :no_printed_sides, class: Feature do
    feature_type { Feature.feature_types[:integer] }
    association :product, factory: :plastic_carrier_bag
    association :feature_label, factory: :no_printed_sides_label
  end

  factory :bag_style, class: Feature do
    feature_type { Feature.feature_types[:option] }
    association :product, factory: :plastic_carrier_bag
    association :feature_label, factory: :bag_style_label
  end

  factory :handle_colour, class: Feature do
    feature_type { Feature.feature_types[:string] }
    association :product, factory: :plastic_carrier_bag
    association :feature_label, factory: :handle_colour_label
  end
end
