Vote.destroy_all
Comment.destroy_all
Article.destroy_all
User.destroy_all

# Create users
users = [
  {name: "Alice", email: "alice@example.com"},
  {name: "Bob", email: "bob@example.com"},
  {name: "Joe", email: "joe@example.com"},
  {name: "Steve", email: "steve@example.com"}
]

users.each do |user_params|
  User.find_or_create_by!(email: user_params[:email]) do |user|
    user.name = user_params[:name]
    user.password = "password"
  end
end

users = User.all

# Create articles and associate them with users
30.times do |i|
  Article.create!(
    title: "Sample Article #{i + 1}",
    link: "https://example.com/article#{i + 1}",
    user: users.sample
  )
end

articles = Article.all

# Create comments
60.times do |i|
  Comment.create!(
    text: "Sample Comment #{i + 1}",
    article: articles.sample,
    user: users.sample
  )
end

comments = Comment.all
replies = []
# Create replies to comments
comments.each do |comment|
  replies << Comment.create!(
    text: "Sample Reply",
    article: comment.article,
    user: users.sample,
    parent_id: comment.id
  )

end

#replies to replies
replies.each do |reply|
  Comment.create!(
    text: "Sample Reply",
    article: reply.article,
    user: users.sample,
    parent_id: reply.id
  )
end

# Generate votes for articles
articles.each do |article|
  users.each do |user|
    Vote.create!(
      votable: article,
      user: user,
      value: [-1, 0, 1].sample
    )
  end
end
comments = Comment.all
# Generate votes for comments
comments.each do |comment|
  users.each do |user|
    Vote.create!(
      votable: comment,
      user: user,
      value: [-1, 0, 1].sample
    )
  end
end
