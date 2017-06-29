require 'rails_helper'

RSpec.feature "Showing a friend's workout" do
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

  let!(:exercise_1) {build :exercise, user: @user1, activity_date: random_date }
  let!(:exercise_2) {build :exercise, user: @user2, activity_date: random_date }

  scenario "shows friend's workout for last 7 days" do
    exercise_1.save(validate: false) # bypasses activity date can't be in the past validation
    exercise_2.save(validate: false) # bypasses activity date can't be in the past validation

    visit "/"

    click_link "My Lounge"
    click_link @user2.full_name
    expect(page).to have_content(@user2.full_name + "'s Exercises")
    expect(page).to have_content(exercise_2.workout_details)
    expect(page).to have_css("div#chart")
  end
end