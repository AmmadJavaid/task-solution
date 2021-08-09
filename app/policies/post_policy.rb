class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def create?
    user
  end

  def update?
    user
  end

  def destroy?
    user
  end
end
