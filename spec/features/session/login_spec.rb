require 'features/spec_helper'

feature 'Login', js: true do
  it 'will success login' do
    manager = create(:manager, password: '12345678')

    visit login_path
    sleep 1

    find_by_id('sign_in_email').set(manager.email)
    find_by_id('sign_in_password').set('12345678')
    click_button 'Вход'

    expect(page).to have_css('.navbar .dropdown-toggle strong',
                             text: manager.email)
  end
end
