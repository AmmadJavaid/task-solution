class User < ApplicationRecord
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :posts, foreign_key: 'creator_id', dependent: :destroy
  has_many :comments
end
