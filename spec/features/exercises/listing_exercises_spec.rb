require 'rails_helper'

RSpec.feature "Listing exercises" do

  before do
    @user1 = create(:user,  first_name: Faker::Name.first_name,
                              last_name:   Faker::Name.last_name,
                              email:       Faker::Internet.email,
                              password:    Faker::Internet.password)

    @user2 = create(:user,  first_name: Faker::Name.first_name,
                            last_name:   Faker::Name.last_name,
                            email:       Faker::Internet.email,
                            password:    Faker::Internet.password)

    @following = Friendship.create(user: @user1, friend: @user2)

    login_as(@user1, scope: :user)
  end

  let!(:exercises) { build_list :exercise, 3, user: @user1, activity_date: random_date }

  scenario "shows user's workout log for the last 7 days" do
    exercises.each do |exercise|
      exercise.save(validate: false) # bypasses activity date can't be in the past validation
    end

    visit "/"

    click_link "My Lounge"

    expect(page).to have_content(exercises[0].duration)
    expect(page).to have_content(exercises[0].workout_details)
    expect(page).to have_content(exercises[0].activity_date)

    expect(page).to have_content(exercises[1].duration)
    expect(page).to have_content(exercises[1].workout_details)
    expect(page).to have_content(exercises[1].activity_date)
  end

  scenario "shows no exercises if none created" do
    @user1.exercises.delete_all

    visit "/"

    click_link "My Lounge"

    expect(page).to have_content('No Workouts Yet')
  end

  scenario "shows a list of user's friends" do
    visit "/"

    click_link "My Lounge"
    expect(page).to have_content("My Friends")
    expect(page).to have_link(@user2.full_name)
    expect(page).to have_link("Unfollow")
  end
end