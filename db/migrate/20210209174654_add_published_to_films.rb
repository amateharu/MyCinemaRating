class AddPublishedToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :published, :boolean, default: false
  end
end
