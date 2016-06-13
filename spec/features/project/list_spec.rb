require 'features/spec_helper'

feature 'Projects list', js: true do
  before { login_as(create(:manager), as: :manager) }

  it 'will have correct page' do
    project = create(:project)

    visit projects_path

    expect(page).to have_link(project.name,
                              href: edit_project_path(project))
    expect(page).to have_link(project.manager.full_name,
                              href: edit_manager_path(project.manager))
    expect(page).to have_link('Добавить', href: new_project_path)
    expect(page).to have_css('.actions .destroy')
  end

  it 'will find projects by name' do
    devs     = create(:project)
    project = create(:project, name: 'Managers')

    visit projects_path

    find(:css, '#grid_f_name').set(devs.name)
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.name)
    expect(page).to_not have_content(project.name)
  end

  it 'will find projects.managers by name' do
    manager1 = create(:manager, full_name: 'Manager first')
    manager2 = create(:manager, full_name: 'Manager last')

    devs     = create(:project, manager: manager1)
    project = create(:project, manager: manager2)

    visit projects_path

    find(:css, '#grid_f_managers_full_name').set('Manager first')
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.name)
    expect(page).to_not have_content(project.name)
  end

  it 'will find projects.managers by name' do
    devs     = create(:project)
    project = create(:project)

    visit projects_path

    find(:css, '#grid_f_clients_company').set(devs.clients.first.company)
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.name)
    expect(page).to_not have_content(project.name)
  end

  it 'will delete project' do
    devs = create(:project)

    visit projects_path

    find(:css, '.actions .destroy').click

    expect(page).to_not have_content(devs.name)
  end
end

