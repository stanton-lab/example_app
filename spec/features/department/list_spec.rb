require 'features/spec_helper'

feature 'Department list', js: true do
  before { login_as(create(:manager, department: nil), as: :manager) }

  it 'will have correct page' do
    department = create(:department)

    visit departments_path

    expect(page).to have_link(department.name,
                              href: edit_department_path(department))
    expect(page).to have_link('Добавить', href: new_department_path)
    expect(page).to have_css('.actions .destroy')
  end

  it 'will find departments by name' do
    devs     = create(:department)
    managers = create(:department, name: 'Managers')

    visit departments_path

    find(:css, '#grid_f_name').set(devs.name)
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.name)
    expect(page).to_not have_content(managers.name)
  end

  it 'will delete department' do
    devs = create(:department)

    visit departments_path

    find(:css, '.actions .destroy').click

    expect(page).to_not have_content(devs.name)
  end
end

