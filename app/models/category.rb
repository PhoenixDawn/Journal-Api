class Category < ApplicationRecord
  has_many :entries, dependent: :destroy
  validates :content, presence: true
end
