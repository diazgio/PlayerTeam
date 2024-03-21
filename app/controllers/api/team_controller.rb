class Api::TeamController < ApplicationController
  def player_process
    team_requirements = JSON.parse(request.body.read)
    team = []

    team_requirements.each do |requirement|
      position = requirement["position"]
      main_skill = requirement["mainSkill"]
      number_of_players = requirement["numberOfPlayers"]

      players = TeamBuilderService.find_best_players(position, main_skill, number_of_players)

      if players.nil? || players.empty?
        render json: { error: "Insufficient number of players for position: #{position}" }, status: :unprocessable_entity
        return
      else
        team.concat(players)
      end
    end
    
    render json: team
  end
end