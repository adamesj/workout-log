require 'rails_helper'

RSpec.feature "Searching for a user" do
  let!(:users) { build_pair :user, last_name: "Snow" }

  scenario "with existing name returning all users" do
    users.each do |user|
      user.save
    end

    visit "/"

    fill_in "search_name", with: "#{users[0].last_name}"
    click_button "Search"

    expect(page).to have_content(users[0].full_name)
    expect(page).to have_content(users[1].full_name)
    expect(current_path).to eq("/pages/search")
  end
end