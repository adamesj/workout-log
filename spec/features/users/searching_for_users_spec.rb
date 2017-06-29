require 'rails_helper'

RSpec.feature "Searching for a user" do
  before do
    @user1 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   "Snow",
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)

    @user2 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   "Snow",
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)
  end

  scenario "with existing name returning all users" do
    visit "/"

    fill_in "search_name", with: "#{@user1.last_name}"
    click_button "Search"

    expect(page).to have_content("#{@user1.full_name}")
    expect(page).to have_content("#{@user2.full_name}")
    expect(current_path).to eq("/pages/search")
  end
end