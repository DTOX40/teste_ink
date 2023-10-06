class Order < ApplicationRecord
  belongs_to :product

  validates :client_name, presence: true
  validates :shipping, presence: true
  validates :product_id, presence: true
end
