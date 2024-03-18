class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position
  has_many :player_skills

  def player_skills
    object.player_skills.map do |skill|
      { id: skill.id, skill: skill.skill, value: skill.value, player_id: skill.player_id}
    end
  end
end
