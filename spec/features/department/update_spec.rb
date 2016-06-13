require 'features/spec_helper'

feature 'Update department record', js: true do
  it 'will successfully update' do
    department = create(:department)
    login_as(create(:manager, department: department), as: :manager)

    visit departments_path
    click_link(department.name)

    fill_in('Название', with: 'Cool Devs')
    click_button('Сохранить')

    expect(page).to have_content('Cool Devs')
  end
end
