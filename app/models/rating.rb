# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :film, optional: true

  validates :user_rating, presence: true
end
