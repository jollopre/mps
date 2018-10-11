FactoryBot.define do
  factory :someone, class: User do
    email { 'someone@somewhere.com' }
    password { '8e67dd1355714239acde098b6f1cf906bde45be6db826dc2caca7536e07ae844' }
    token { 'a_token' }
  end
end
