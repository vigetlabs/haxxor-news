class CommentsController < ApplicationController
  before_action :authorized, only: [:create]

  def show
    comment
    @reply = Comment.new
    @user_votes = Vote.where(user: current_user, votable: @comments.to_a).index_by(&:votable_id)
  end

  def upvote
    vote(1)
    respond_to do |format|
      format.json { render json: {new_score: comment.score} }
    end
  end

  def downvote
    vote(-1)
    respond_to do |format|
      format.json { render json: {new_score: comment.score} }
    end
  end

  def create
    @comment = article.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      if comment.parent_id.present?
        redirect_to article_comment_path(article, @comment.parent_id)
      else
        redirect_to article
      end
    else
      render "articles/show", status: :unprocessable_entity
    end
  end

  private

  def article
    @article ||= Article.find(params[:article_id])
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :parent_id)
  end

  def vote(value)
    vote = comment.votes.find_or_initialize_by(user: current_user)
    if vote.value == value
      vote.update(value: 0)
    else
      vote.update(value: value)
    end
  end
end
