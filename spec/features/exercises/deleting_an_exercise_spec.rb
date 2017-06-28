require 'rails_helper'

RSpec.feature "Deleting an exercise" do
  let!(:valid_user) { create :user }
  let!(:exercise) { create :exercise, user: valid_user }

  scenario "a user deletes an exercise" do
    login_as(valid_user, scope: :user)

    visit "/"

    click_link "My Lounge"

    click_link "Delete"

    expect(page).to have_content("Successfully deleted exercise.")
    expect(page).to have_no_content("Duration (min): 10")
    expect(page).to have_no_content("pushups")
    expect(page).to have_no_content(humanized_date(Date.today))
  end
end