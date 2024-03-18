class Player < ApplicationRecord
  validates :name, :position, presence: true
  has_many :player_skills, dependent: :destroy
  validate :valid_position
  accepts_nested_attributes_for :player_skills

  AVAILABLE_POSITIONS = %w[defender midfielder forward].freeze

  def valid_position
    errors.add(:position, 'is not a valid position') unless AVAILABLE_POSITIONS.include?(self.position)
  end
end
