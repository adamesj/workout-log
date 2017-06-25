require 'rails_helper'

RSpec.feature "New user session" do
  let!(:valid_user) { create :user }

  scenario "with valid credentials" do
    visit "/users/sign_in"

    fill_in "user[email]", with: "#{valid_user.email}"
    fill_in "user[password]", with: "#{valid_user.password}"
    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "with invalid credentials" do
    visit "/users/sign_in"

    fill_in "user[email]", with: "#{valid_user.email}"
    fill_in "user[password]", with: "notmypassword"
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password.")
  end
end