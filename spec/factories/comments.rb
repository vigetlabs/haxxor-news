FactoryBot.define do
  factory :comment do
    text { "Good article!" }
    association :article, factory: :article
    association :user, factory: :user
  end
end
