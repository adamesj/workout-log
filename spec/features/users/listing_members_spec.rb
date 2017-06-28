require 'rails_helper'

RSpec.feature "Listing members" do
  let!(:users) { build_pair :user }

  scenario "shows a list of registered members" do
    users.each do |user|
      user.save
    end

    visit "/pages/dashboard"

    expect(page).to have_content("List of Members")
    expect(page).to have_content(users[0].full_name)
    expect(page).to have_content(users[1].full_name)
  end
end