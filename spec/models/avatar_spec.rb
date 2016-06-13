require 'rails_helper'

RSpec.describe Avatar, type: :model do
  it { should belong_to(:avatarable) }

  subject { Avatar.new }
  it { should have_attr_accessor(:crop_x,
                                 :crop_y,
                                 :crop_h,
                                 :crop_w,
                                 :avatar_tmp,
                                 :width,
                                 :height) }
end
