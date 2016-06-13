require 'features/spec_helper'

feature 'Add new department', js: true do

  it 'will success create department' do
    login_as(create(:manager), as: :manager)

    visit clients_path
    click_link('Добавить')

    fill_in('Компания', with: 'Developers')
    fill_in('ФИО', with: 'Developer James')
    fill_in('Email', with: 'Developers@mail.ru')
    fill_in('Телефон', with: '(222) 222-22-22')
    click_button('Сохранить')

    expect(page).to have_content('Запись успешно добавлена')
    expect(page).to have_content('Developers')

    expect(page).to  have_xpath("//input[@value='Developer James']")
  end

  it 'will dont create department' do
    login_as(create(:manager), as: :manager)

    visit clients_path
    click_link('Добавить')

    fill_in('Компания', with: '')
    click_button('Сохранить')

    expect(page).to have_current_path(clients_path)
    expect(page).to have_css('.help-block', text: 'не может быть пустым')
  end

end
