class InitSchema < ActiveRecord::Migration[6.1]
  def change
    create_users_table
    create_game_turn_table
  end

  private

  def create_users_table
    create_table(:users, id: :serial) do |t|
      t.string(:name, null: false, unique: true)
      t.integer(:winning_count)

      t.timestamps
    end
  end

  def create_game_turn_table
    create_table(:game_turns, id: :serial) do |t|
      t.references(:user, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
