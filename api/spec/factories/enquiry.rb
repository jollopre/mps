FactoryBot.define do
  factory :enquiry
  factory :enquiry1, class: Enquiry do
    quantity { 2 } 
    association :product, factory: :plastic_carrier_bag
    association :quotation, factory: :quotation1
  end

  factory :enquiry2, class: Enquiry do
    quantity { 3 }
    association :product, factory: :tissue_paper
    association :quotation, factory: :quotation2
  end
end
