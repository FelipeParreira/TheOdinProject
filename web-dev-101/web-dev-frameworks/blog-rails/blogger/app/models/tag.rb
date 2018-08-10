class Tag < ApplicationRecord
    has_many :taggings, :dependent => :destroy, dependent: :destroy
    has_many :articles, through: :taggings
end
