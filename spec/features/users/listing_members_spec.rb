require 'rails_helper'

RSpec.feature "Listing members" do
  before do
    @user1 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)

    @user2 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)
  end

  scenario "shows a list of registered members" do
    visit "/pages/dashboard"

    expect(page).to have_content("List of Members")
    expect(page).to have_content(@user1.full_name)
    expect(page).to have_content(@user2.full_name)
  end
end