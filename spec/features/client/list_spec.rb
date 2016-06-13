require 'features/spec_helper'

feature 'Clients list', js: true do
  before { login_as(create(:manager), as: :manager) }

  it 'will have correct page' do
    client = create(:client)

    visit clients_path

    expect(page).to have_link(client.company,
                              href: edit_client_path(client))
    expect(page).to have_link('Добавить', href: new_client_path)
    expect(page).to have_css('.actions .destroy')
  end

  it 'will find clients by name' do
    devs     = create(:client)
    client = create(:client, company: 'same company')

    visit clients_path

    find(:css, '#grid_f_company').set(devs.company)
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.company)
    expect(page).to_not have_content(client.company)
  end

  it 'will find clients by contact person' do
    devs     = create(:client)
    client = create(:client, company: 'same company')

    visit clients_path

    find(:css, '#grid_f_contact_people_full_name').set(devs.contact_people.first.full_name)
    find(:css, '#grid_submit_grid_icon').click

    expect(page).to have_content(devs.company)
    expect(page).to_not have_content(client.company)
  end

  it 'will delete client' do
    devs = create(:client)

    visit clients_path

    find(:css, '.actions .destroy').click

    expect(page).to_not have_content(devs.company)
  end
end

