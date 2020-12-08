class User < ApplicationRecord
  has_many :products
  has_many :transactions
  has_many :review_users
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :address, presence: true

  # validate :birth_date_cannot_be_in_the_future

  # def birth_date_cannot_be_in_the_future
  #   birth_date >= Time.now.strftime("%Y%m%d").to_i
  #   errors.add(:birth_date, "can't be in the future")
  # end
end
