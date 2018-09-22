class Api::PlayersController < ApplicationController
  def index
    @players = current_user.players
    render 'players'
  end

  def create
    @player = current_user.players.new(player_params)
    if @player.save
      render @player, status: :created
    else
      render json: "", status: :conflict
    end
  end

  def destroy
    @player = current_user.players.where(id: params[:player_id]).first
    if !@player
      render json: "", status: :not_found
    elsif @player.destroy
      render json: "", status: :ok
    else
      render json: "", status: :conflict
    end
  end
  
  private
    def player_params
      params.require(:player).permit(:first_name, :last_name, :rating, :handedness)
    end
end