class ArticlesController < ApplicationController
  before_action :authorized, only: [:new, :create]
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(20)
  end

  # Testing
  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  # Testing 3
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :link)
  end
end
