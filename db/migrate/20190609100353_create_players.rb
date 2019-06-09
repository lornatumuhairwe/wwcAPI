class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players, id: :integer do |t|
      t.string :name, null: false
      t.references :team, foreign_key: true, type: :integer, null: false
      t.string :position

      t.timestamps
    end
  end
end
