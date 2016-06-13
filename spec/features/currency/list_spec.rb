require 'features/spec_helper'

feature 'Currencies list', js: true do
  before { login_as(create(:manager), as: :manager) }

  it 'will have correct page' do
    currency = create(:currency)

    visit currencies_path
    expect(page).to have_content(currency.name)

    expect(find_field('currency_default').value).to  eq currency.default.to_s

  end

  it 'will modify currency' do
    currency = create(:currency, default: 33)

    visit currencies_path
    find(:css, '#currency_default').set('44')

    find_button('Сохранить').trigger('click')

    expect(page).to have_current_path(currencies_path)
    expect(find_field('currency_default').value).to  eq '44'
    expect(page).to_not have_css('.help-block')
  end

end

