class TeamBuilderService
  def self.find_best_players(position, main_skill, number_of_players)
    players = Player.joins(:player_skills).where(players: { position: position }).distinct

    players_with_skill = players.select do |player|
      player.player_skills.exists?(skill: main_skill)
    end

    if players_with_skill.empty?
      players_ordered_by_skill = players.sort_by do |player|
        -player.player_skills.maximum(:value)
      end
      selected_players = players_ordered_by_skill.take(number_of_players)
      selected_players.map do |player|
        highest_skill = player.player_skills.select { |skill| skill.value == player.player_skills.maximum(:value) }
        {
          name: player.name,
          position: player.position,
          playerSkills: [{
            skill: highest_skill[0].skill,
            value: highest_skill[0].value
          }]
        }
      end
    else
      players_with_skill.sort_by! do |player|
        -player.player_skills.find_by(skill: main_skill)&.value.to_i
      end
      selected_players = players_with_skill.take(number_of_players)
      selected_players.map do |player|
        player_skill_value = player.player_skills.find_by(skill: main_skill)&.value
        {
          name: player.name,
          position: player.position,
          playerSkills: [{
            skill: main_skill,
            value: player_skill_value
          }]
        }
      end
    end
  end
end