FactoryBot.define do
  factory :user do
    first_name {'John'}
    last_name {'Example'}
    email {'example@email.com'}
    password {'password'}
  end

  factory :post do
    content {'text for post'}
    user_id {1}
  end

  factory :comment do
    content {'text for comment'}
    post_id {1}
  end

  factory :friendship do

  end

  factory :like do
    
  end

  factory :friend_request do

  end
end