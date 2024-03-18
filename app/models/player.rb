class Player < ApplicationRecord
  validates :name, :position, presence: true
  has_many :player_skills, dependent: :destroy

  AVAILABLE_POSITIONS = %w[defender midfielder forward].freeze
end
