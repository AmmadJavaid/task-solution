class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    @post.creator_id == user.id
  end

  def destroy?
    update?
  end
end
