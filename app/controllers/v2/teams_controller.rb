module V2
  class TeamsController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
    def index
      json_response({ team: 'Jamaica aka Reggae Galz'})
    end
  end
end
