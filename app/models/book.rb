class Book < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :author, presence: true
  validates :ISBN, presence: true, uniqueness: true
  validates :quantity_available, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
