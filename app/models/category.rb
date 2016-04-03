class Category < ActiveRecord::Base
  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true, uniqueness: true, length: { maximum: 29 }

end
