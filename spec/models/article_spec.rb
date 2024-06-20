require "rails_helper"

RSpec.describe Article, type: :model do
  let(:article) { build(:article) }

  it "should be valid with valid attributes" do
    expect(article.valid?).to be(true)
  end

  it "should not be valid without a title" do
    article.title = nil
    expect(article.valid?).to be(false)
  end

  it "should not be valid without a link" do
    article.link = nil
    expect(article.valid?).to be(false)
  end

  it "should not be valid without a user" do
    article.user = nil
    expect(article.valid?).to be(false)
  end
end
