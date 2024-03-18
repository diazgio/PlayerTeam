class CreatePlayerSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :player_skills do |t|
      t.string :skill_name, null: false
      t.integer :value, null: false
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
