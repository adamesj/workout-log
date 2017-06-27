class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.activity_date.present? && record.activity_date < Date.today
      record.errors.add(:activity_date, "can't be in the past")
    end
  end
  # this is a helper validator class for checking the date in the exercise model
end