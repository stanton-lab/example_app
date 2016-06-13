require 'features/spec_helper'

feature 'Works list', js: true do
  before { login_as(create(:manager), as: :manager) }

  it 'will have correct page' do
    work = create(:work)

    visit works_path

    expect(page).to have_link(work.name,
                              href: edit_work_path(work))
    expect(page).to have_link('Добавить', href: new_work_path)
    expect(page).to have_css('.actions .destroy')
  end

  it 'will find works by name' do
    devs     = create(:work)
    work = create(:work, name: 'Managers')

    visit works_path

    find(:css, '#grid_f_name').set(devs.name)
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.name)
    expect(page).to_not have_content(work.name)
  end

  it 'will find works.department by name' do
    devs     = create(:work)
    work = create(:work)

    visit works_path

    find(:css, '#grid_f_departments_name').set(devs.department.name)
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.name)
    expect(page).to_not have_content(work.name)
  end

  it 'will delete work' do
    devs = create(:work)

    visit works_path

    find(:css, '.actions .destroy').click

    expect(page).to_not have_content(devs.name)
  end
end

