module Avatar::Form
  class Crop < ::Reform::Form

    validates :crop_x, presence: true

    property :crop_x
    property :crop_y
    property :crop_h
    property :crop_w
  end
end