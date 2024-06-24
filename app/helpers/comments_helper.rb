module CommentsHelper
  def render_comment_tree(comment)
    content_tag :li do
      concat content_tag(:p, comment.text)
      concat content_tag(:p) {
        safe_concat "Posted by "
        safe_concat link_to(comment.user.name, comment.user)
        safe_concat " on #{comment.created_at.strftime("%B %d, %Y at %I:%M %p")}"
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
