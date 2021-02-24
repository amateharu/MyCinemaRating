class CreateRatingsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :film_id
      t.integer :user_rating

      t.timestamps
    end
  end
end
