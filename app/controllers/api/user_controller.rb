class Api::UserController < ActionController::API
  def create
    render json: "", status: 409
  end
end
