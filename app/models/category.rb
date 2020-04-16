class Category < ApplicationRecord
  # relationships
  has_many :article_categories
  has_many :articles, through: :article_categories

  # validations
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end
