FactoryBot.define do
  factory :someone, class: User do
    email { 'someone@somewhere.com' }
    password { 'secret_password' }
    token { 'a_token' }
  end
end
