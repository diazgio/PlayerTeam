class PlayerSkill < ApplicationRecord
  belongs_to :player

  AVAILABLE_SKILLS = %w[attack defense speed strength stamina].freeze
end
