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
# Create replies to comments
90.times do |i|
  comment = comments.sample
  Comment.create!(
    text: "Sample Reply #{i + 1}",
    article: comment.article,
    user: users.sample,
    parent_id: comment.id
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
