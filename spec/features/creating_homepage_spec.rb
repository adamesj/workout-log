# Should see a link called 'Home'
# Should see a link called 'Fitness Club'
# Should see a content called 'Workout Lounge'
# Should see a content called 'Show off your workout'
require 'rails_helper'

RSpec.feature "Creating Homepage" do
  let!(:valid_user) { create :user }

  scenario "with valid credentials" do
    login_as(valid_user, scope: :user)

    visit "/"

    expect(page).to have_link "Fitness Club"
    expect(page).to have_link "My Lounge"
    expect(page).to have_link "Log out"

    expect(page).to have_content "Workout Lounge"
    expect(page).to have_content "Show off your workout"
  end

  scenario "with invalid credentials" do
    visit "/"

    expect(page).to have_link "Fitness Club"
    expect(page).to have_link "Log in"

    expect(page).to have_content "Workout Lounge"
    expect(page).to have_content "Show off your workout"
  end
end