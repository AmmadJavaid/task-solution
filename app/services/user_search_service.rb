class UserSearchService
  attr_accessor :scope, :params

  def initialize(scope, params)
    self.scope = scope
    self.params = params
  end

  def call
    @scope = @scope.where.not(id: params[:exclude_users]) if params[:exclude_users].present?
    @scope = @scope.where('lower(name) ILIKE ?', params[:name].downcase) if params[:name].present?

    @scope
  end
end
