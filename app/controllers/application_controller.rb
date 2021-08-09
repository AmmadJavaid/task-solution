class ApplicationController < ActionController::API
  include Respondable
  include Pagy::Backend
  include Pundit

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid do |e|
    render_error(errors: e.record.errors)
  end
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def user_not_authorized
    render status: :unauthorized, json: { message: 'You are not allowed to perform this action.' }
  end
end
