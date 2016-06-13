require 'features/spec_helper'

feature 'Periods list', js: true do
  before { login_as(create(:manager), as: :manager) }

  it 'will have correct page' do
    period = create(:period)

    visit periods_path

    expect(page).to have_content(period.starts_at)
    expect(page).to have_content(period.ends_at)
    expect(page).to have_button('Добавить')
  end

  it 'will add new period' do
    build(:period)

    visit periods_path
    page.execute_script("$('#period_starts_at').val('2016-06-07')")
    page.execute_script("$('#period_ends_at').val('2016-06-09')")
    fill_in('period_currencies_periods_attributes_0_value', with: 44)

    click_button('Добавить')

    expect(page).to have_current_path(periods_path)
    expect(page).to have_content('2016-06-07')
  end

  it 'will have error if periods overlap ' do
    period = create(:period, starts_at: '2016-06-07', ends_at: '2016-06-09')

    visit periods_path
    page.execute_script("$('#period_starts_at').val('2016-06-08')")
    page.execute_script("$('#period_ends_at').val('2016-06-10')")
    fill_in('period_currencies_periods_attributes_0_value', with: 44)

    click_button('Добавить')

    expect(page).to have_current_path(periods_path)
    expect(page).to_not have_content('2016-06-10')
  end

end

