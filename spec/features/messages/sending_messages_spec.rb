require 'rails_helper'

RSpec.feature "Sending a message" do
  before do
    @user1 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)

    @user2 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)
    @user3 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)

    @room_name = @user1.first_name + '-' + @user1.last_name
    @room = Room.create!(name: @room_name, user_id: @user1.id)

    login_as(@user1)

    Friendship.create(user: @user2, friend: @user1)
    Friendship.create(user: @user3, friend: @user1)
  end

  scenario "followers show up in chatroom window" do
    visit "/"

    click_link "My Lounge"
    expect(page).to have_content(@room_name)

    fill_in "message_field", with: "Hello"
    click_button "Post"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(@user2.full_name)
      expect(page).to have_link(@user3.full_name)
    end
  end
end