# == Schema Information
#
# Table name: avatars
#
#  id              :integer          not null, primary key
#  image           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  avatarable_id   :integer
#  avatarable_type :string
#
# Indexes
#
#  index_avatars_on_avatarable_type_and_avatarable_id  (avatarable_type,avatarable_id)
#

class Avatar < ActiveRecord::Base
  belongs_to :avatarable, polymorphic: true

  mount_uploader :image, ImageUploader

  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w, :avatar_tmp, :width, :height

  def crop
    # image.cache_stored_file!
    # image.retrieve_from_cache!(image.cache_name)
    # image.recreate_versions!
    image.recreate_versions! if crop_x.present?
  end

  def width
    image.store_dimensions if @width.blank?
    @width
  end

  def height
    image.store_dimensions if @height.blank?
    @height
  end

  def url(size = :thumb)
    image.send(size).url
  end
end
