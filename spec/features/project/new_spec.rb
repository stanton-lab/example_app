require 'features/spec_helper'

feature 'Add new project', js: true do

  it 'will success create project' do
    client = create(:client)
    login_as(create(:manager), as: :manager)

    visit projects_path
    click_link('Добавить')

    fill_in('Название проекта', with: 'Developers project')
    find('.project_clients').all('input').first.set(client.id)
    click_button('Сохранить')

    expect(page).to have_content('Запись успешно добавлена')
    expect(page).to have_content('Developers project')
  end

  it 'will dont create project' do
    client = create(:client)
    login_as(create(:manager), as: :manager)

    visit projects_path
    click_link('Добавить')

    fill_in('Название проекта', with: '')
    find('.project_clients').all('input').first.set(client.id)
    click_button('Сохранить')

    expect(page).to have_current_path(projects_path)
    expect(page).to have_css('.help-block', text: 'не может быть пустым')
  end
end
