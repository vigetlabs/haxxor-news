FactoryBot.define do
  factory :vote do
    association :user, factory: :user
    association :votable, factory: :article
    value { 0 }
  end
end
