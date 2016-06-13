class CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type
  process :optimize
  process :store_dimensions
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}".tap do |s|
      s.prepend 'test_' if Rails.env.test?
    end
  end

  def optimize
    manipulate! do |img|
      return img unless img.mime_type.match /jpe?g/

      img.strip
      img.combine_options do |c|
        c.quality '80'
        c.depth '8'
        c.interlace 'plane'
      end

      img
    end
  end

  def store_dimensions
    if file && model && model.respond_to?(:width) && model.respond_to?(:height)
      resize_to_fit(600, 600)
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

  private
  def model_random_id
    var = :"@#{mounted_as}_random_id"
    model.instance_variable_get(var) || model.instance_variable_set(var, random_id)
  end

  def random_id
    SecureRandom.urlsafe_base64(32)
  end
end
