class TechnicalFeature < ActiveRecord::Base
  belongs_to :product

  validate :check_power_accordance

  private

  def check_power_accordance
    if total_power != nil && one_lamp_power != nil && amount_of_lamps != nil
      errors.add(:total_power, 'have to be equal to sum power of all laps') if
          BigDecimal(total_power) != (BigDecimal(one_lamp_power) * BigDecimal(amount_of_lamps))
    end

  end

end
