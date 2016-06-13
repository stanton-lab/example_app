class PeriodsController < ApplicationController
  add_breadcrumb 'Курсы валют', :periods_path

  def index
    authorize! :read, Period
    periods = Period.real.order(starts_at: 'desc')
    period = Period.new
    Currency.active.each do |currency|
      period.currencies_periods.build(currency_id: currency.id)
    end
    currencies_periods = period.currencies_periods
    render 'index', locals: { periods: periods, period: period, currencies_periods: currencies_periods }
  end

  def create
    authorize! :create, Period
    period = Period.new(period_params)
    template        = 'create'
    unless period.save
      template      = 'error'
    end
    respond_to do |format|
      format.js { render template, locals: { period: period } }
    end
  end

  private
  def period_params
    params
      .require(:period)
      .permit(:starts_at, :ends_at, { currencies_periods_attributes: [:value, :id]})
  end
end

