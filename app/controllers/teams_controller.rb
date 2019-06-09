class TeamsController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  def index
    @teams = Team.all
    render json: @teams
  end

  def create
    @team = Team.create!(todo_params)
    render json: @team, status: :created
  end

  def show
    render json: @team
  end

  def update
    @team.update(todo_params)
    render json: @team
  end

  def destroy
    @team.destroy
    head :no_content
  end

  private

  def todo_params
    params.require(:team).permit(:name)
  end

  def set_todo
    @team = Team.find(params[:id])
  end
end
