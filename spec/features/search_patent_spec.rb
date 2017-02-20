require 'rails_helper'
require 'contexts/search_patent.rb'
require 'capybara/rspec'

describe "Search Patent", :type => :feature do

  context 'With found Patent' do

    before(:all) do
      create_search_patent_context
      #CREAR LAS PAUTAS
    end

    it 'render results page with vehicle\'s data' do
      allow_any_instance_of(VehicleFinder).to receive(:execute).and_return([Vme.first.attributes])
      visit '/'
      within '.search-patent' do
        fill_in 'search_patent', with: 'AAA000'
        click_button 'Comenzar'
      end
    end
  end

  context 'With not found Patent' do
  end
end