class Api::LoginController < ApplicationController
  skip_before_action :authenticate

  def create
    @user = User.find_by(email: auth_params[:email])
    if !@user
      render json: "", status: :not_found
    elsif @user.authenticate(auth_params[:password])
      @token = Auth.issue({user: @user.id})
      render @user, status: :ok
    else
      render json: "", status: :unauthorized
    end
  end
  
  private
    def auth_params
      params.permit(:email, :password)
    end
end