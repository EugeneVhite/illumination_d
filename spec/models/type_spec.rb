require 'spec_helper'

describe Type do
  it 'should have valid factory' do
    expect(build(:type)).to be_valid
  end

  it 'should not be valid without name' do
    expect(build(:type, name: nil)).not_to be_valid
  end
end
