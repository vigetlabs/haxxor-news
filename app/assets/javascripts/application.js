document.addEventListener("DOMContentLoaded", function() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    const upvoteButtons = document.querySelectorAll('.upvote-button');
    const downvoteButtons = document.querySelectorAll('.downvote-button');
  
    // Function to handle voting
    function handleVote(articleId, path) {
      fetch(`/articles/${articleId}/${path}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({})
      })
      .then(response => response.json())
      .then(data => {
        document.getElementById(`score-${articleId}`).textContent = data.new_score;
      })
      .catch(error => console.log('Error:', error));
    }

    upvoteButtons.forEach(button => {
      button.addEventListener('click', function(e) {
        e.preventDefault();
        const articleId = this.dataset.articleId;
        handleVote(articleId, 'upvote');
      });
    });

    downvoteButtons.forEach(button => {
      button.addEventListener('click', function(e) {
        e.preventDefault();
        const articleId = this.dataset.articleId;
        handleVote(articleId, 'downvote');
      });
    });
});
