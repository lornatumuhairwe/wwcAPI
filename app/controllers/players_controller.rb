class PlayersController < ApplicationController
  before_action :set_team
  before_action :set_player, only: [:show, :update, :destroy]

  def index
    @players = @team.players
    json_response(@players)
  end

  def show
    json_response(@player)
  end

  def create
    @player = @team.players.create!(player_params)
    json_response(@player, :created)
  end

  def update
    @player.update(player_params)
    json_response(@player)
  end

  def destroy
    @player.destroy

    head :no_content
  end

  private

  def player_params
    params.require(:player).permit(:name, :position)
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_player
    @player = @team.players.find(params[:id])
  end
end
