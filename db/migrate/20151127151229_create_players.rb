class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.string :jersey_number
      t.string :nickname
      t.string :nationality
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
