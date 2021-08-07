json.id user.id
json.name user.name
json.email user.email

json.posts user.posts do |post|
  json.partial! 'posts/post', post: post
end
