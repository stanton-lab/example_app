require 'rails_helper'

describe Project::Decorator do
  include Rails.application.routes.url_helpers

  let(:project) { create(:project, is_active: true) }

  it 'return decorated created_at not = striftime format' do
    expect(project.decorate.created_at).to_not eq(project.created_at)
  end

  it 'return decorated created time/date' do
    expect(project.decorate.created_at)
      .to eq(project.created_at.strftime(format = '%d-%m-%Y %H:%M:%S'))
  end

  it 'return decorated updated time/date' do
    expect(project.decorate.updated_at)
      .to eq(project.updated_at.strftime(format = '%d-%m-%Y %H:%M:%S'))
  end

  it 'return decorated status true' do
    expect(project.decorate.status)
      .to eq('В процесе')
  end

  it 'return decorated status false' do
    project.is_active = false
    expect(project.decorate.status)
      .to eq('Завершен')
  end

  it 'return decorated status_label false' do
    project.is_active = false
    expect(project.decorate.status_label)
      .to eq('<span class="label label-danger">Завершен</span>')
  end

  it 'return decorated status_label true' do
    expect(project.decorate.status_label)
      .to eq('<span class="label label-primary">В процесе</span>')
  end

  it 'return decorated avatar_url if image present' do
    expect(project.decorate.avatar_url(:thumb))
      .to eq(project.avatar && project.avatar.url(:thumb))
  end

  it 'return avatar image path if avatar nil' do
    project = create(:project, avatar: nil)

    expect(project.decorate.avatar_url(:thumb))
      .to eq( ActionController::Base.helpers.image_path('no-image-found.jpg'))
  end
end