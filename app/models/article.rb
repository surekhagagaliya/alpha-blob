class Article < ActiveRecord::Base
  # relationships
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  # validations
  validates :title, presence: true, length: {minimum: 2, maximum: 10}
  validates :description, presence: true, length: {minimum: 5, maximum: 20}

end
