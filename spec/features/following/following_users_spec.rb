require 'rails_helper'

RSpec.feature "Following a user" do
  before do
    @user1 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)

    @user2 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)
    login_as(@user1, scope: :user)
  end

  scenario "with existing name returning all users" do
    visit "/dashboard"

    expect(page).to have_content(@user1.full_name)
    expect(page).to have_content(@user2.full_name)

    # save_and_open_page
    # puts current_url
    # require 'pry'; binding.pry

    href = "/friendships?friend_id=#{@user1.id}"
    expect(page).not_to have_link("Follow", href: href)

    link = "a[href='/friendships?friend_id=#{@user2.id}']"
    find(link).click

    href = "/friendships?friend_id=#{@user2.id}"
    expect(page).not_to have_link("Follow", href: href)
  end
end