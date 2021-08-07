json.posts @posts do |post|
  json.partial! 'post', post: post
end

json.meta @pagy
