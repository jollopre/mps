FactoryBot.define do
  factory :supplier, class: Supplier do
    reference { 'REF1' }
    email { 'someone@somewhere.com' }
  end
end
