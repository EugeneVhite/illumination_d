require 'spec_helper'

describe TechnicalFeature do
  it 'should have valid factory' do
    expect(build(:technical_feature)).to be_valid
  end
  describe '#check_power_accordance' do
    it 'should not validate object without power accordance' do
      expect(build(:technical_feature_with_wrong_power)).not_to be_valid
    end

    it 'should validate object with power accordance' do
      expect(build(:technical_feature_with_correct_power)).to be_valid
    end

    context 'nil power arguments' do
      it 'has no power arguments' do
        expect(build(:technical_feature_without_power_arguments)).to be_valid
      end

    end
  end


end
