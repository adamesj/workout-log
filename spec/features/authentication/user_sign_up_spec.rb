require 'rails_helper'

RSpec.feature "User Sign up" do
  scenario "a new user signs up" do
    visit '/users/sign_up'
    fill_in "user[email]", with: "billydkid@mail.com"
    fill_in "user[password]", with: "secret123"
    fill_in "user[password_confirmation]", with: "secret123"
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end