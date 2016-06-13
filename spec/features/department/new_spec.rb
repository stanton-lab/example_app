require 'features/spec_helper'

feature 'Add new department', js: true do

  it 'will success create department' do
    login_as(create(:manager), as: :manager)

    visit departments_path
    click_link('Добавить')

    fill_in('Название', with: 'Developers')
    click_button('Сохранить')

    expect(page).to have_content('Запись успешно добавлена')
    expect(page).to have_content('Developers')
  end

  it 'will dont create department' do
    login_as(create(:manager), as: :manager)

    visit departments_path
    click_link('Добавить')

    fill_in('Название', with: '')
    click_button('Сохранить')

    expect(page).to have_current_path(departments_path)
    expect(page).to have_css('.help-block', text: 'не может быть пустым')
  end

end
