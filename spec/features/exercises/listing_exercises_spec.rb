require 'rails_helper'

RSpec.feature "Listing exercises" do
  let!(:valid_user) { create :user }
  let!(:exercises) { build_list :exercise, 3, user: valid_user, activity_date: random_date }

  scenario "shows user's workout log for the last 7 days" do
    exercises.each do |exercise|
      exercise.save(validate: false) # bypasses activity date can't be in the past validation
    end

    login_as(valid_user, scope: :user)

    visit "/"

    click_link "My Lounge"

    expect(page).to have_content(exercises[0].duration)
    expect(page).to have_content(exercises[0].workout_details)
    expect(page).to have_content(exercises[0].activity_date)

    expect(page).to have_content(exercises[1].duration)
    expect(page).to have_content(exercises[1].workout_details)
    expect(page).to have_content(exercises[1].activity_date)

    expect(page).to have_content(exercises[2].duration)
    expect(page).to have_content(exercises[2].workout_details)
    expect(page).to have_content(exercises[2].activity_date)
  end
end