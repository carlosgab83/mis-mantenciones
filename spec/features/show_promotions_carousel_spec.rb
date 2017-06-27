require 'rails_helper'
require 'contexts/show_promotions_carousel.rb'
require 'capybara/rspec'

# TODO: Rename tests for looking on left and right panels when user search. Not yet.

describe "Show promotions on carousel", :type => :feature do

  context 'With generic promotions' do

    before(:each) do
      create_show_promotions_carousel_context
    end

    it 'render results page with generic promotions' do
      allow_any_instance_of(VehicleFinder).to receive(:execute).and_return([Rvm.first.attributes.merge(Vme.first.attributes)])
      visit '/'
      click_button 'Busca Servicios'
      click_link 'Mi Pauta'
      within '.search-patent' do
        fill_in 'search_patent', with: 'AAA000'
        click_button 'Consultar'
      end

      expected_promotions_array = ["product_promotion_shown_1", "vehicle_promotion_shown_1", "service_promotion_shown_1",
                                    "product_promotion_shown_2", "vehicle_promotion_shown_2", "service_promotion_shown_2"]

      expect(page.all(:css, '#promo-carousel a').map{|a|a[:title]}).to eq(expected_promotions_array)
    end
  end

  context 'With vme specific promotions' do

    before(:each) do
      create_specific_show_prmotions_carousel_context
    end

    it 'render results page with specific promotions' do
      allow_any_instance_of(VehicleFinder).to receive(:execute).and_return([Rvm.first.attributes.merge(Vme.first.attributes)])
      visit '/'
      click_button 'Busca Servicios'
      click_link 'Mi Pauta'
      within '.search-patent' do
        fill_in 'search_patent', with: 'AAA000'
        click_button 'Consultar'
      end

      expected_promotions_array = ["specific_product_promotion_shown_1", "specific_vehicle_promotion_shown_1", "specific_service_promotion_shown_1",
                                    "product_promotion_shown_1", "vehicle_promotion_shown_1", "service_promotion_shown_1",
                                    "product_promotion_shown_2", "vehicle_promotion_shown_2", "service_promotion_shown_2"]

      expect(page.all(:css, '#promo-carousel a').map{|a|a[:title]}).to eq(expected_promotions_array)
    end
  end
end