require 'spec_helper'

feature 'User Sign Up' do
  scenario 'New user arrives at root path wanting to sign up' do
    visit '/'
    click_link('Sign Up')
    expect(current_path).to eq('/users/signup')
    expect(page).to have_content('Please Enter Your Details')
    sign_up
    expect(current_path).to eq('/')
    expect(page).to have_content('Welcome, Chit Ter')
  end

  feature 'Defends against invalid input' do
    before do
      visit('/users/signup')
    end
    scenario 'Invalid Email Format' do
      expect{ sign_up(email:'hello') }.not_to change(User, :count)
      expect(current_path).to eq('/users/signup')
      expect(page).to have_content('Email has an invalid format')
    end
    scenario 'Duplicate Username' do
      sign_up
      visit('/users/signup')
      expect{ sign_up }.not_to change(User, :count)
      expect(current_path).to eq('/users/signup')
      expect(page).to have_content('Username is already taken')
    end
    scenario 'Passwords do not match' do
      expect{ sign_up(password_confirmation:'wrong') }.not_to change(User, :count)
      expect(current_path).to eq('/users/signup')
      expect(page).to have_content('Password does not match the confirmation')
    end
  end
end
