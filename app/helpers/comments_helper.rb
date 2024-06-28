module CommentsHelper
  def render_comment_tree(comment)
    content_tag :li do
      concat content_tag(:p, comment.text)
      concat content_tag(:div, style: "display: flex; align-items: center;") {
        safe_concat "Posted by "
        safe_concat link_to(comment.user.name, comment.user)
        safe_concat " on #{comment.created_at.strftime("%B %d, %Y at %I:%M %p")}"
        safe_concat " - Score: "
        safe_concat content_tag(:span, comment.score, id: "score-Comment-#{comment.id}")

        safe_concat button_to("Upvote", upvote_article_comment_path(comment.article, comment), method: :post, class: "btn btn-sm upvote-button", data: {votable_type: "Comment", votable_id: comment.id, article_id: comment.article.id})
        safe_concat button_to("Downvote", downvote_article_comment_path(comment.article, comment), method: :post, class: "btn btn-sm downvote-button", data: {votable_type: "Comment", votable_id: comment.id, article_id: comment.article.id})
      }
      concat content_tag(:p) {
        safe_concat link_to("reply", article_comment_path(comment.article, comment))
      }

      if comment.replies.any?
        concat(content_tag(:ul) do
          comment.replies.each do |reply|
            concat render_comment_tree(reply)
          end
        end)
      end
    end
  end
end
