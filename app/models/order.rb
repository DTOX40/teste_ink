# app/models/order.rb

class Order < ApplicationRecord
  belongs_to :store
  belongs_to :product

  validates :client_name, presence: true
  validates :shipping, presence: true
  validates :product_id, presence: true
  validates :shipping, numericality: { greater_than: 0 }
  validate :check_stock_quantity, on: :create, unless: :skip_stock_validation

  attr_accessor :skip_stock_validation

  private

  def check_stock_quantity
    if product.stock < shipping
      errors.add(:base, 'Quantidade em estoque insuficiente para criar a ordem.')
    end
  end
end
