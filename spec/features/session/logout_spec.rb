require 'features/spec_helper'

feature 'Logout', js: true do
  it 'will success logout' do
    manager = create(:manager)
    login_as manager, scope: :manager

    visit root_path

    within('.navbar-right') do
      click_link(manager.email)
    end
    sleep 1
    click_link('Выход')
    
    expect(page).to have_current_path(login_path)
  end
end