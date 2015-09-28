require 'spec_helper'

describe Manufacturer do
  describe '#validation' do

    it 'should have valid factory' do
      expect(build(:manufacturer)).to be_valid
    end

    it 'should not be valid without name' do
      expect(build(:manufacturer, name: nil)).not_to be_valid
    end
  end

  describe '#country destruction' do
    it 'should destroy country if country has no more manufacturers' do
      country = create(:country)
      manufacturer = create(:manufacturer, country: country)

      manufacturer.destroy
      expect(Country.exists?(country.id)).to be false
    end
  end
end
