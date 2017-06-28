require 'rails_helper'

RSpec.feature "Editing an exercise" do
  let!(:valid_user) { create :user }
  let!(:exercise) { create :exercise, user: valid_user }

  scenario "a user edits an exercise" do
    login_as(valid_user, scope: :user)

    visit "/"

    click_link "My Lounge"

    click_link "Edit"

    fill_in "Duration", with: 60
    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated.")
    expect(page).to have_content("Duration (min): 60")
  end
end