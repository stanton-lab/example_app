class CurrenciesController < ApplicationController
  add_breadcrumb 'Валюты по умолчанию', :currencies_path

  def index
    authorize! :read, Currency
    currencies = Currency.active.order(created_at: 'desc')
    render 'index', locals: { currencies: currencies}
  end

  def update
    authorize! :update, Currency
    currency        = Currency.find(params[:id])
    template    = 'update'
    unless currency.update(currency_params)
      template = 'error'
    end
    respond_to do |format|
      format.js { render template, locals: { currency: currency } }
    end
  end

  private

  def currency_params
    currency_params = [:default]
    params
      .require(:currency)
      .permit(currency_params)
  end
end
