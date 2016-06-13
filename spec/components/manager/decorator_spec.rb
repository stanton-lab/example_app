require 'rails_helper'

describe Manager::Decorator do
  include Rails.application.routes.url_helpers

  let(:manager) { create(:manager) }

  it 'return decorated avatar_url if image present' do
    expect(manager.decorate.avatar_url(:thumb))
      .to eq(manager.avatar && manager.avatar.url(:thumb))
  end

  it 'return avatar image path if avatar nil' do
    manager = create(:manager, avatar: nil)

    expect(manager.decorate.avatar_url(:thumb))
      .to eq( ActionController::Base.helpers.image_path('admin/avatar/5.jpg'))
  end
end