require 'spec_helper'

describe RecommendedPlace do
  it 'should have valid factory' do
    expect(build(:recommended_place)).to be_valid
  end

  it 'should not be valid without name' do
    expect(build(:recommended_place, name: nil)).not_to be_valid
  end
end
