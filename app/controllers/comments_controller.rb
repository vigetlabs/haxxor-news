class CommentsController < ApplicationController
  before_action :authorized, only: [:create]

  def show
    @comment = Comment.find(params[:id])
    @reply = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article
    else
      @comments = @article.comments.order(created_at: :desc)
      render "articles/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :parent_id)
  end
end
