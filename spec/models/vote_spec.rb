require "rails_helper"

RSpec.describe Vote, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment) { create(:comment, article: article, user: user) }
  let(:vote) {create(:vote, votable: article, user: user)}
  let(:comment_vote) {create(:vote, votable: comment, user: user)}

  it "should be valid with valid attributes" do
    expect(vote.valid?).to be(true)
  end

  it "should be valid with comment as votable" do
    expect(comment_vote.valid?).to be(true)
  end

  it "value should be present" do
    vote.value = nil
    expect(vote.valid?).to be(false)
  end

  it "should not be valid with a value other than -1, 0, or 1" do
    vote.value = 2
    expect(vote.valid?).to be(false)
  end

  it "should belong to a user" do
    vote.user = nil
    expect(vote.valid?).to be(false)
  end

  it "should belong to a votable" do
    vote.votable = nil
    expect(vote.valid?).to be(false)
  end
end
