FactoryBot.define do
  factory :user do
    first_name {'John'}
    last_name {'Example'}
    email {'example@email.com'}
    password {'password'}
  end
end