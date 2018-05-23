require 'rails_helper'


RSpec.describe HomeBanner, :type => :model do

  describe 'validations' do

    it "has a valid factory" do
      expect(build(:home_banner)).to be_valid
    end

    it "has an invalid factory" do
      expect(build(:invalid_home_banner)).not_to be_valid
    end
  end

end
