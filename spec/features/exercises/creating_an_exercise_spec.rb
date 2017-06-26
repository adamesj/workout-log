require 'rails_helper'

RSpec.feature "Create a new exercise" do
  let!(:valid_user) { create :user }

  scenario "with a valid user" do
    login_as(valid_user, scope: :user)

    visit "/"

    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")

    fill_in "Duration", with: 90
    fill_in "exercise[workout_details]", with: "Pushups and situps"
    select '2017', :from => 'exercise[activity_date(1i)]'
    select 'June', :from => 'exercise[activity_date(2i)]'
    select '21', :from => 'exercise[activity_date(3i)]'
    click_button "Create Exercise"

    expect(page).to have_content("Way to go! You've added a new exercise!")

    exercise = Exercise.last # grab the last exercise record
    expect(current_path).to eq(user_exercise_path(valid_user, exercise)) # exercise can only exists if a user has created it
    expect(exercise.user_id).to eq(valid_user.id) # ensure the user id of the exercise belongs to the user created by FactoryGirl
  end
end