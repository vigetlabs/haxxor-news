module CommentsHelper
  def render_comment_tree(comment)
    content_tag :div do
      concat content_tag(:table, border: "0", cellpadding: "0", cellspacing: "0") {
        concat content_tag(:tbody) {
          concat content_tag(:tr) {
            concat content_tag(:td, valign: "top", class: "votelinks") {
              content_tag(:center) {
                concat button_to(upvote_article_comment_path(comment), method: :post, class: "btn btn-sm upvote-button", data: {votable_type: "Comment", votable_id: comment.id, article_id: comment.article.id}) {
                  content_tag(:i, "", class: "fas fa-arrow-up")
                }
                concat button_to(downvote_article_comment_path(comment), method: :post, class: "btn btn-sm downvote-button", data: {votable_type: "Comment", votable_id: comment.id, article_id: comment.article.id}) {
                  content_tag(:i, "", class: "fas fa-arrow-down")
                }
              }
            }
            concat content_tag(:td, comment.text, valign: "top", style: "padding-left: 10px;")
          }
          concat content_tag(:tr) {
            concat content_tag(:td, "", colspan: "2")
            concat content_tag(:td, class: "subtext") {
              safe_concat content_tag(:span, "#{comment.score} points", id: "score-Comment-#{comment.id}", class: "score")
              concat raw("&nbsp;")
              safe_concat "by"
              concat raw("&nbsp;")
              safe_concat link_to(comment.user.name, comment.user)
              concat raw("&nbsp;")
              safe_concat content_tag(:span, "on #{comment.created_at.strftime("%B %d, %Y at %I:%M %p")}")
              safe_concat " | "
              safe_concat link_to(" reply", article_comment_path(comment.article, comment))
            }
          }
          concat content_tag(:tr, "", style: "height:5px")
        }
      }
      if comment.replies.any?
        concat(content_tag(:ul, style: "list-style-type: none; padding-left: 20px;") do
          comment.replies.each do |reply|
            concat render_comment_tree(reply)
          end
        end)
      end
    end
  end
end
