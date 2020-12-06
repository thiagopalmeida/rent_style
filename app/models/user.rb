class User < ApplicationRecord
  has_many :products
  has_many :transactions
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :address, presence: true
end
