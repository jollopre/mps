FactoryBot.define do
  factory :customer
  factory :ref1, class: Customer do
    reference { 'REF1' }
    email { 'ref1@somewhere.com' }
  end

  factory :ref2, class: Customer do
    reference { 'REF2' }
    email { 'ref2@somewhere.com' }
  end
end
