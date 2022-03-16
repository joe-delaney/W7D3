require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content("Sign Up!")
  end

  feature 'signing up a user' do
    before(:each) do 
      visit new_user_url
      fill_in('Username:', with: "amin")
      fill_in('Password:', with: "password")

      click_button "Sign Up"
  end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content "Profile"
    end

  end
end

feature 'logging in' do
  before(:each) do 
    visit new_user_url
    fill_in('Username:', with: "amin")
    fill_in('Password:', with: "password")
    click_button "Sign Up"
    click_button "Log out"
    fill_in('Username:', with: "amin")
    fill_in('Password:', with: "password")
    click_button "Sign In"
  end
  scenario 'shows username on the homepage after login' do
    expect(page).to have_content "amin"
  end
end

feature 'logging out' do
  before(:each) do
    visit new_user_url
    fill_in('Username:', with: "amin")
    fill_in('Password:', with: "password")
    click_button "Sign Up"
    click_button "Log out"
  end 

  scenario 'begins with a logged out state' do
    expect(page).to_not have_content "Log out"
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).to_not have_content "amin"
  end

end