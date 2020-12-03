class Transaction < ApplicationRecord
  validates :payment_method, presence: true
  belongs_to :user
  belongs_to :product
end
