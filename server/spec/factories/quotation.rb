FactoryBot.define do
  factory :quotation
  factory :quotation1, class: Quotation do
    association :customer, factory: :ref1
  end

  factory :quotation2, class: Quotation do
    association :customer, factory: :ref1
  end

  factory :quotation3, class: Quotation do
    association :customer, factory: :ref2
  end
end
