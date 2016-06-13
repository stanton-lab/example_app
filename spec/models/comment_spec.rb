require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:commentable) }

  it 'have valid factory' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it 'have validation on content' do
    comment = build(:comment, content: nil)
    expect(comment).to_not be_valid
  end
end
