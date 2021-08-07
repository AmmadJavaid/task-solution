json.id post.id
json.title post.title
json.description post.description
json.creator post.creator, :name, :email

json.comments post.comments, :message, :created_at
