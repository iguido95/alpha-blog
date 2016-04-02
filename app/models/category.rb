class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 29 }

end
