class User < ApplicationRecord
  has_many :products
  has_many :transactions
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :address, presence: true
end
