require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  let(:comment) { build :comment }

  context 'validations' do
    it 'should return in valid comment' do
      comment.assign_attributes(message: nil)

      expect(comment.valid?).to be false
      expect(comment.errors[:message].present?).to be true
    end
  end
end
