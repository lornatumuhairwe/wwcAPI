module V1
  class TeamsController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
    def index
      @teams = Team.all
      json_response(@teams)
    end

    def create
      @team = Team.create!(todo_params)
      json_response(@team, :created)
    end

    def show
      json_response(@team)
    end

    def update
      @team.update(todo_params)
      json_response(@team)
    end

    def destroy
      @team.destroy
      head :no_content
    end

    private

    def todo_params
      params.permit(:name)
    end

    def set_todo
      @team = Team.find(params[:id])
    end
  end
end
