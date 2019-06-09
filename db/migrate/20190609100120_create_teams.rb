class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams, id: :integer do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
