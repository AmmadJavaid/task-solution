class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user
  end

  def update?
    user && comment
  end

  def destroy?
    user && comment
  end
end
