class Product < ApplicationRecord
  belongs_to :store
  has_many :orders, dependent: :delete_all

  validates :name, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :sku, presence: true
  validates :store_id, presence: true
end
