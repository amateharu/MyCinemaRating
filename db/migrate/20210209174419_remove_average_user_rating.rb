class RemoveAverageUserRating < ActiveRecord::Migration[5.2]
  def change
    remove_column :films, :average_user_rating
  end
end
