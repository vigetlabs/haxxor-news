# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing records
User.destroy_all
Article.destroy_all

# Create users
users = [
<<<<<<< HEAD
  {name: "Alice", email: "alice@example.com", password: "password"},
  {name: "Bob", email: "bob@example.com", password: "password"},
  {name: "Joe", email: "joe@example.com", password: "password"},
  {name: "Steve", email: "steve@example.com", password: "password"}
]

users.each do |user_params|
  User.create!(user_params)
=======
  {name: "Alice", email: "alice@example.com"},
  {name: "Bob", email: "bob@example.com"}
]

users.each do |user_params|
  User.find_or_create_by!(email: user_params[:email]) do |user|
    user.name = user_params[:name]
    user.password = "password"
  end
>>>>>>> users
end

# Ensure users are created before creating articles
users = User.all

# Create articles and associate them with users
30.times do |i|
  Article.create!(
    title: "Sample Article #{i + 1}",
    link: "https://example.com/article#{i + 1}",
    user: users.sample
  )
end
