class Api::UserController < ApplicationController
  skip_before_action :authenticate, only: [:create]
  
  def create
    @user = User.new(user_params)
    if @user.save
      @token = Auth.issue(user: @user.id)
      render @user, status: :created
    else
      render json: "", status: :conflict
    end
  end

  def update
    @user = User.where(id: params[:user_id]).first
    if !@user
      render json: "", status: :not_found
    elsif @user.update_attributes(user_params)
      @token = Auth.issue(user: @user.id)
      render @user, status: :ok
    else
      render json: "", status: :conflict
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end
