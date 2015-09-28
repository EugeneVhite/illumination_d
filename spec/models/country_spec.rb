require 'spec_helper'

describe Country do
  it 'should have valid factory' do
    expect(build(:country)).to be_valid
  end

  it 'should not be valid without name' do
    expect(build(:country, name: nil)).not_to be_valid
  end
end
