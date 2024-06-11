FactoryBot.define do
  factory :article do
    title { "Ruby on Rails" }
    link { "https://rubyonrails.org/" }
    association :user
  end
end
