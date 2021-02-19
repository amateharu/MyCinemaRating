class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
    t.string :title
    t.text :description
    t.string :image
    t.string :director
    t.text :actors
    t.integer :average_user_rating
    t.integer :imdb_rating
    t.integer :user_id
    t.timestamps
    end
  end
end
