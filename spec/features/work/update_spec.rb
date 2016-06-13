require 'features/spec_helper'

feature 'Add new work', js: true do

  it 'will success create work' do
    work = create(:work, name: 'Super Name of work', percent: 95)
    login_as(create(:manager), as: :manager)

    visit works_path
    expect(page).to have_content('Super Name of work')
    expect(page).to have_content('95')

    click_link(work.name)

    fill_in('Название', with: 'New name for work')
    fill_in('Процентная ставка специалиста', with: '64')
    click_button('Сохранить')

    expect(page).to have_content('Запись успешно изменена')
    expect(page).to have_content('New name for work')
    expect(page).to have_content('64')
  end

end
