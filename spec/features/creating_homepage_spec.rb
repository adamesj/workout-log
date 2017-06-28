# Should see a link called 'Home'
# Should see a link called 'Fitness Club'
# Should see a content called 'Workout Lounge'
# Should see a content called 'Show off your workout'
require 'rails_helper'

RSpec.feature "Creating Homepage" do
  scenario "on the homepage" do
    visit "/"

    expect(page).to have_link "Fitness Club"
    expect(page).to have_link "Home"
    expect(page).to have_content "Workout Lounge"
    expect(page).to have_content "Show off your workout"
  end
end