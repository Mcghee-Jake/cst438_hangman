class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :word
      t.string :letters_revealed
      t.integer :remaining_guesses
      
      t.timestamps
    end
  end
end
