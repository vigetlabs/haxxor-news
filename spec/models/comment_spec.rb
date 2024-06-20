require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment) { create(:comment, article: article, user: user) }

  it "should be valid" do
    expect(comment.valid?).to be(true)
  end

  it "text should be present" do
    comment.text = " "
    expect(comment.valid?).to be(false)
  end

  it "should belong to an article" do
    comment.article = nil
    expect(comment.valid?).to be(false)
  end

  it "should belong to a user" do
    comment.user = nil
    expect(comment.valid?).to be(false)
  end
end
