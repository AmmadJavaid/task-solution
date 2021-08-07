class PostSearchService
  attr_accessor :scope, :params


  def initialize(scope, params)
    self.scope = scope
    self.params = params
  end

  def call
    @scope = @scope.where('lower(title) ILIKE ?', params[:title].downcase) if params[:title].present?
    @scope
  end
end
