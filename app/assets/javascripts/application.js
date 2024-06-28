document.addEventListener("DOMContentLoaded", function() {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const upvoteButtons = document.querySelectorAll('.upvote-button');
  const downvoteButtons = document.querySelectorAll('.downvote-button');

  // Function to handle voting
  function handleVote(votableId, votableType, path, articleId = null) {
    let url;
    if (votableType === 'Article') {
      url = `/articles/${votableId}/${path}`;
    } else if (votableType === 'Comment') {
      url = `/articles/${articleId}/comments/${votableId}/${path}`;
    }
    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({})
    })
    .then(response => response.json())
    .then(data => {
      document.getElementById(`score-${votableType}-${votableId}`).textContent = data.new_score;
    })
    .catch(error => console.log('Error:', error));
  }

  upvoteButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      const votableId = this.dataset.votableId;
      const votableType = this.dataset.votableType;
      const articleId = this.dataset.articleId;
      handleVote(votableId, votableType, 'upvote');
    });
  });

  downvoteButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      const votableId = this.dataset.votableId;
      const votableType = this.dataset.votableType;
      const articleId = this.dataset.articleId;
      handleVote(votableId, votableType, 'downvote', articleId);
    });
  });
});

