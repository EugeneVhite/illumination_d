class Placing < ActiveRecord::Base
  belongs_to :product
  belongs_to :recommended_place

  before_destroy :try_to_destroy_place

  private

  def try_to_destroy_place
    if Placing.where(recommended_place: self.recommended_place).count == 1
      if Placing.where(recommended_place: self.recommended_place).take == self
        self.recommended_place.destroy
      end
    end
  end
end
