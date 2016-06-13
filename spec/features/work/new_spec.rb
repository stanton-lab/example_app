require 'features/spec_helper'

feature 'Add new work', js: true do

  it 'will success create work' do
    login_as(create(:manager), as: :manager)

    visit works_path
    click_link('Добавить')

    fill_in('Название', with: 'Developers')
    find('#work_department_id').find(:xpath, 'option[2]').select_option
      first('.radio_buttons')
      .all('label').last
      .trigger('click')
    fill_in('Процентная ставка специалиста', with: '14')
    click_button('Сохранить')

    expect(page).to have_content('Запись успешно добавлена')
    expect(page).to have_content('Developers')
  end

  it 'will dont create work' do
    login_as(create(:manager), as: :manager)

    visit works_path
    click_link('Добавить')

    fill_in('Название', with: '')
    click_button('Сохранить')

    expect(page).to have_current_path(works_path)
    expect(page).to have_css('.help-block', text: 'не может быть пустым')
  end
end
