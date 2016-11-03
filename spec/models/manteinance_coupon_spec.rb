require 'rails_helper'


RSpec.describe ManteinanceCoupon, :type => :model do

  describe 'validations' do

    it "has a valid factory" do
      expect(build(:manteinance_coupon)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_manteinance_coupon)).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:pauta_id) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:client_id) }
    it { is_expected.to validate_presence_of(:branch_id) }
    it { is_expected.to validate_presence_of(:date) }
  end

end