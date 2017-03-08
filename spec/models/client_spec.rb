require 'rails_helper'


RSpec.describe Client, :type => :model do

  describe 'validations' do

    it "has a valid factory" do
      expect(build(:client)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_client)).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

end