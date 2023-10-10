class Store < ApplicationRecord
  has_many :orders
  has_many :products, dependent: :delete_all

  validates :name, presence: true
  validates :description, presence: true
end
