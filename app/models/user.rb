class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :posts, foreign_key: 'creator_id', dependent: :destroy
  has_many :comments
end
