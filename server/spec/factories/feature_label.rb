FactoryBot.define do
  factory :width_label, class: FeatureLabel do
    name { 'Width' }
  end

  factory :no_printed_sides_label, class: FeatureLabel do
    name { 'No. Printed Sides' }
  end

  factory :bag_style_label, class: FeatureLabel do
    name { 'Bag Style' }
  end

  factory :handle_colour_label, class: FeatureLabel do
    name { 'Handle Colour' }
  end
end
