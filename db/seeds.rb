# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
articles = [
  { title: "Testing Rails Applications", link: "https://guides.rubyonrails.org/testing.html" },
  { title: "Ruby on Rails Guides (v7.1.3.4)", link: "https://guides.rubyonrails.org/index.html" },
  { title: "Getting Started with Rails", link: "https://guides.rubyonrails.org/getting_started.html" },
  { title: "Active Record Basics", link: "https://guides.rubyonrails.org/active_record_basics.html" }
]

articles.each do |article_params|
  Article.find_or_create_by!(title: article_params[:title]) do |article|
    article.link = article_params[:link]
  end
end