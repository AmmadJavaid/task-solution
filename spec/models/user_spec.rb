require 'rails_helper'

RSpec.describe 'User', type: :model do
  let(:user) { build :user }

  context 'validations' do
    it 'should return in valid user' do
      user.assign_attributes(name: nil)

      expect(user.valid?).to be false
      expect(user.errors[:name].present?).to be true
    end

    it 'should return in valid user' do
      user.assign_attributes(email: nil)

      expect(user.valid?).to be false
      expect(user.errors[:email].present?).to be true
    end

    it 'should return in valid user' do
      user.assign_attributes(password: nil)

      expect(user.valid?).to be false
      expect(user.errors[:password].present?).to be true
    end
  end
end
