class Product < ApplicationRecord
  belongs_to :store
  has_many :orders, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sku, presence: true
  validates :store_id, presence: true
end
