class Order < ActiveRecord::Base
  has_many :products

  validates_presence_of :name, :message => "lal"
  validates_presence_of :phone_number


end
