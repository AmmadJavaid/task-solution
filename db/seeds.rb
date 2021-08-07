users = [
  {name: "user_1", email: "user_1@abc.com", password: "password"},
  {name: "user_2", email: "user_2@abc.com", password: "password"},
]

User.create(users)

puts 'Users created'

posts = [
  { title: "Post 1", description: "this is first test post", creator: User.first },
  { title: "Post 2", description: "this is second test post", creator: User.last },
]

Post.create(posts)
puts 'Posts created'

comments = [
  {message: "comment 1", post: Post.first, user: User.first},
  {message: "comment 2", post: Post.first, user: User.last},
  {message: "comment 1", post: Post.last, user: User.first},
]

Comment.create(comments)
puts 'Comments created'
