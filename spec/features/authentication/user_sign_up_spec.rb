require 'rails_helper'

RSpec.feature "New user session" do
  scenario "with valid credentials" do
    visit '/users/sign_up'
    fill_in "user[first_name]", with: "Donkey"
    fill_in "user[last_name]", with: "Kong"
    fill_in "user[email]", with: "dk@mail.com"
    fill_in "user[password]", with: "banana123"
    fill_in "user[password_confirmation]", with: "banana123"
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "with no credentials" do
    visit '/users/sign_up'
    fill_in "user[first_name]", with: ""
    fill_in "user[last_name]", with: ""
    fill_in "user[email]", with: ""
    fill_in "user[password]", with: ""
    fill_in "user[password_confirmation]", with: ""
    click_button "Sign up"
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end