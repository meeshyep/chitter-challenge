require 'spec_helper'

feature 'Making Peeps' do
  before do
    sign_up
  end

  scenario 'Logged In User Creates a Peep' do
    visit '/home'
    fill_in :peep, with: 'Hello, World'
    click_button 'Peep'
    expect(current_path).to eq('/home')
    expect(page).to have_content('(Chit Ter) @sir_chitter: Hello, World')
  end
end
