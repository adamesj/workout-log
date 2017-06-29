require 'rails_helper'

RSpec.feature "Unfollowing a friend" do
  before do
    @user1 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)

    @user2 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)
    login_as(@user1)

    @following = Friendship.create(user: @user1, friend: @user2)
  end

  scenario do
    visit "/"

    click_link "My Lounge"
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_selector ".alert-notice", text: "#{@user2.full_name} unfollowed."
  end
end