# encoding: utf-8
require 'open-uri'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :main do
    process resize_to_fit: [600, 600]
  end

  version :thumb do
    process :crop
    process resize_to_fill: [270, 270]
  end

  version :small do
    process :crop
    process resize_to_fill: [40, 40]
  end

  def extension_white_list
    %w(jpg jpeg gif png svg)
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path('new-gallery-img.png')
  end

  def store_dimensions
    if file && model
      resize_to_limit(600, 600)
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

  private

  def crop
    if model.crop_x.present?
      resize_to_fit(model.width, model.height)
      crop_params = "#{model.crop_w.to_i}x#{model.crop_h.to_i}+#{model.crop_x.to_i}+#{model.crop_y.to_i}"
      manipulate! do |img|
        img.crop(crop_params)
        img
      end
    end
  end
end
