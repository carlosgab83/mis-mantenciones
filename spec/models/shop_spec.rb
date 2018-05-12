require 'rails_helper'


RSpec.describe Shop, :type => :model do

  describe 'validations' do

    it "has a valid factory" do
      expect(build(:shop)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_shop)).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:installation_enabled) }
    it { is_expected.to validate_inclusion_of(:click_n_collect_enabled).in_array([true, false]) }
    it { is_expected.to validate_inclusion_of(:delivery_enabled).in_array([true, false]) }
  end

end