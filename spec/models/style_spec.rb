require 'spec_helper'

describe Style do
  it 'should have valid factory' do
    expect(build(:style)).to be_valid
  end

  it 'should not be valid without name' do
    expect(build(:style, name: nil)).not_to be_valid
  end
end
