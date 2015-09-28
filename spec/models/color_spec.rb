require 'spec_helper'

describe Color do
  it 'should have valid factory' do
    expect(build(:color)).to be_valid
  end

  it 'should not be valid without name' do
    expect(build(:color, name: nil)).not_to be_valid
  end

  # Almost functional tests

end
