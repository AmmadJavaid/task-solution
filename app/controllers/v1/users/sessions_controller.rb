module V1
  module Users
    class SessionsController < Devise::SessionsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        if current_user
          render json: { message: 'You are logged in.' }, status: :ok
        else
          render json: { message: 'Invalid email or password' }, status: 422
        end
      end

      def respond_to_on_destroy
        log_out_success && return if current_user

        log_out_failure
      end

      def log_out_success
        render json: { message: "You are logged out." }, status: :ok
      end

      def log_out_failure
        render status: :unauthorized, json: {}
      end
    end
  end
end
