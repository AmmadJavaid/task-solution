module V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show]

    def index
      params[:exclude_users] = current_user.id
      @pagy, @users = pagy UserSearchService.new(User, params).call
    end

    def show; end

    def update_profile
      render_okay @user if @user.update(update_profile_params)
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def update_profile_params
      params.require(:user).permit(:name, :email)
    end
  end
end
