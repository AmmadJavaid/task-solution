require 'rails_helper'

RSpec.describe 'Post', type: :model do
  let(:post) { build :post }

  context 'validations' do
    it 'should return in valid post' do
      post.assign_attributes(title: nil)

      expect(post.valid?).to be false
      expect(post.errors[:title].present?).to be true
    end

    it 'should return in valid post' do
      post.assign_attributes(description: nil)

      expect(post.valid?).to be false
      expect(post.errors[:description].present?).to be true
    end
  end
end
