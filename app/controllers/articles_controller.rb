class ArticlesController < ApplicationController
  before_action :authorized, only: [:new, :create]
  before_action :set_article, only: [:show, :upvote, :downvote]
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(20)
    @user_votes = Vote.where(user: current_user, votable: @articles.to_a).index_by(&:votable_id)
  end

  def show
    @comments = @article.comments.without_parent.order(created_at: :desc)
    @comment = Comment.new
  end

  def upvote
    vote(1)
    respond_to do |format|
      format.json { render json: { new_score: @article.score } }
    end
  end

  def downvote
    vote(-1)
    respond_to do |format|
      format.json { render json: { new_score: @article.score } }
    end
  end

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

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :link)
  end

  def vote(value)
    @vote = @article.votes.find_or_initialize_by(user: current_user)
    if @vote.value == value
      @vote.update(value: 0)
    else
      @vote.update(value: value)
    end
  end
end
