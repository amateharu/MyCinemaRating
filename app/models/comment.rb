# frozen_string_literal: true

# Comment model
class Comment < ApplicationRecord
  belongs_to :film, optional: true
  validates :body, presence: true, length: { minimum: 5 }
end
