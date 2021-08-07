class Post < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :comments, dependent: :destroy
end
