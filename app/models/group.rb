class Group < ActiveRecord::Base
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :users_joined, through: :joins, source: :user
  validates :name, :description, presence: true
  validates :name, length: {minimum: 6}
  validates :description, length: {minimum: 11}
end
