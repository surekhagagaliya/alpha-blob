class ArticleCategory < ApplicationRecord
  # relationships
  belongs_to :article
  belongs_to :category
end
