class AddFilmToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :film_id, :integer
  end
end
