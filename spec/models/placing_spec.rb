require 'spec_helper'

describe Placing do

  describe '#validation' do
    it 'should have valid factory' do
      expect(build(:placing)).to be_valid
    end
  end

  describe '#recommended places destruction' do

    it 'should destroy recommended place if place has no any other placings' do
      recommended_place = create(:recommended_place)
      placing = create(:placing, recommended_place: recommended_place)

      placing.destroy

      expect(RecommendedPlace.exists?(recommended_place.id)).to be false
    end

    it 'should not destroy recommended place if place has other placings' do
      recommended_place = create(:recommended_place)
      placing_first = create(:placing, recommended_place: recommended_place)
      placing_second = create(:placing, recommended_place: recommended_place)

      placing_first.destroy

      expect(RecommendedPlace.exists?(recommended_place.id)).to be true
    end
  end
end
