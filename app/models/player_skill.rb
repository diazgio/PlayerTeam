class PlayerSkill < ApplicationRecord
  belongs_to :player
  validates :skill, :value, presence: true
  validate :valid_skill

  AVAILABLE_SKILLS = %w[attack defense speed strength stamina].freeze

  def valid_skill
    errors.add(:skill, 'is not a valid skill') unless AVAILABLE_SKILLS.include?(self.skill)
  end
end
