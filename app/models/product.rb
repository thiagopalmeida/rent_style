class Product < ApplicationRecord
  validates :description, presence: true, length: { minimum: 10, maximum: 200 }
  validates :category, presence: true, length: { minimum: 5, maximum: 30 }
  validates :size, presence: true
  validates :price, presence: true

  belongs_to :user
  has_many :transactions
  has_many_attached :photos, dependent: :destroy
end
