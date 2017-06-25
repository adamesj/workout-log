require 'rails_helper'

RSpec.feature "Destroy user session" do
  let!(:valid_user) { create :user }

  scenario "with valid credentials" do
    login_as(valid_user, scope: :user)
    visit "/"
    click_link "Log out"
    expect(page).to have_content("Signed out successfully.")
  end
end