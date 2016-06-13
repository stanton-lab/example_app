require 'features/spec_helper'

feature 'Update client record', js: true do
  it 'will successfully update' do
    login_as(create(:manager), as: :manager)
    client = create(:client)
    visit clients_path
    click_link(client.company)

    fill_in('Компания', with: 'Cool Devs')
    first(:css, '.nested-fields').fill_in('ФИО', with: 'Janny Jons')
    click_button('Сохранить')

    expect(page).to have_content('Cool Devs')

    expect(first(:css, '.nested-fields').first(:css, 'input').value).to  eq 'Janny Jons'
  end

  it 'will add new phone' do
    login_as(create(:manager), as: :manager)
    client = create(:client)
    visit clients_path
    click_link(client.company)

    first(:css, '.nested-fields').click_link('+ Добавить телефон')
    first(:css, '.nested-fields')
      .first(:css, '.phones')
      .all('.nested-fields').last
      .fill_in('Телефон', with: '(333) 333-33-33')
    click_button('Сохранить')

    expect(page).to  have_xpath("//input[@value='(333) 333-33-33']")
  end
end
