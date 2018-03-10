class Api::PlayersController < ApplicationController
  def index
    @players = Player.all
    render 'players'
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      render @player, status: :created
    else
      render json: "", status: :conflict
    end
  end
  
  private
    def player_params
      params.require(:player).permit(:first_name, :last_name, :rating, :handedness)
    end
end