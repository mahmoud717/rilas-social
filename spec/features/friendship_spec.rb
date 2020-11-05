require 'rails_helper'
require 'capybara/rails'
RSpec.feature 'Friendships', type: :feature do
  before :each do
    @user1 = User.create!(name: 'mahmoud', email: 'mahmoudmohammad717@email.com', password: 'mahmoud')
    @user2 = User.create!(name: 'omar11', email: 'omar11@email.com', password: 'omar11')
  end

  scenario 'user 1 logs in and sends invitation then user 2 accepts it' do
    visit new_user_session_path
    fill_in 'Email', with: 'mahmoudmohammad717@email.com'
    fill_in 'Password', with: 'mahmoud'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    click_link 'Add Friend'
    click_link 'Sign out'

    visit new_user_session_path
    fill_in 'Email', with: 'omar11@email.com'
    fill_in 'Password', with: 'omar11'
    click_button 'Log in'
    expect(page).to have_content('Recent posts')
    visit users_path
    expect(page).to have_selector(:link_or_button, 'confirm')
    expect(page).to have_selector(:link_or_button, 'cancel')
    click_link 'confirm'
  end
end
