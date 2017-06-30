class Exercise < ApplicationRecord
  belongs_to :user
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  validates :workout_details, presence: true, length: { minimum: 3, maximum: 200 }
  validates :activity_date, presence: true
  #validates_with DateValidator
end
