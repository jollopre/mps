FactoryBot.define do
  factory :product
  factory :plastic_carrier_bag, class: Product do
    name { "Plastic Carrier Bag" }
  end

  factory :tissue_paper, class: Product do
    name { "Tissue Paper" }
  end
end
