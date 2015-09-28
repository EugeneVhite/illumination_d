class Manufacturer < ActiveRecord::Base
  belongs_to :country
  has_many :products

  validates_presence_of :name

  before_destroy :try_to_destroy_country

  private

  def try_to_destroy_country
    if self.country
      manufacturers_of_country = Manufacturer.where(country: self.country)
      if manufacturers_of_country.count == 1
        the_last_one = manufacturers_of_country.take
        if the_last_one == self
          self.country.destroy
        end
      end
    end
  end
end
