class Country < ActiveRecord::Base
  has_many :manufacturers
  has_many :products, through: :manufacturers

  validates_presence_of :name
end
