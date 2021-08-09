module V1
  module Users
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        register_success && return if resource.persisted?

        register_failed
      end

      def register_success
        render json: { message: 'Signed up sucessfully.' }
      end

      def register_failed
        render json: { errors: resource.errors.full_messages }, status: 422
      end
    end
  end
end
