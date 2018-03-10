class Player < ApplicationRecord
  enum handedness: [ :left, :right ]
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :rating, presence: true
  validates :handedness, presence: true
  # This prevents users with identical names but allows same first OR last
  validates :first_name, uniqueness: { scope: :last_name }
end
