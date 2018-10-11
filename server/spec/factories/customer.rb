FactoryBot.define do
  factory :ref1, class: Customer do
    reference { 'REF1' }
  end

  factory :ref2, class: Customer do
    reference { 'REF2' }
  end
end
