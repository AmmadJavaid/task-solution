class ApplicationController < ActionController::API
  include Respondable
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(errors: e.record.errors)
  end

  def current_user
    User.first
  end
end
