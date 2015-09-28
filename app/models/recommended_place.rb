class RecommendedPlace < ActiveRecord::Base
  has_many :placings
  has_many :products, through: :placings

  validates_presence_of :name
end
