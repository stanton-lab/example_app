# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string
#  is_deleted       :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  manager_id       :integer
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :manager

  scope :ordered, -> { order(created_at: :desc) }

  validates :content,
            presence: true,
            length:   { minimum: 2, maximum: 3000 }
end
