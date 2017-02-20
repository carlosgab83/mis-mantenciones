require 'rails_helper'


RSpec.describe Coupon, :type => :model do

  describe 'validations' do

    it "has a valid factory" do
      expect(build(:coupon)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_coupon)).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:promotion_id) }
    it { is_expected.to validate_presence_of(:client_id) }
    it { is_expected.to validate_presence_of(:date) }
  end

end