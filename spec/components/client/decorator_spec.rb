require 'rails_helper'

describe Client::Decorator do
  include Rails.application.routes.url_helpers

  let(:client) { create(:client) }

  it 'return decorated created_at not = striftime format' do
    expect(client.decorate.created_at).to_not eq(client.created_at)
  end

  it 'return decorated created time/date' do
    expect(client.decorate.created_at)
      .to eq(client.created_at.strftime(format = '%d-%m-%Y %H:%M:%S'))
  end

  it 'return decorated updated time/date' do
    expect(client.decorate.updated_at)
      .to eq(client.updated_at.strftime(format = '%d-%m-%Y %H:%M:%S'))
  end

  it 'return decorated avatar_url if image present' do
    expect(client.decorate.avatar_url(:thumb))
      .to eq(client.avatar && client.avatar.url(:thumb))
  end

  it 'return avatar image path if avatar nil' do
    client = create(:client, avatar: nil)

    expect(client.decorate.avatar_url(:thumb))
      .to eq( ActionController::Base.helpers.image_path('no-image-found.jpg'))
  end
end