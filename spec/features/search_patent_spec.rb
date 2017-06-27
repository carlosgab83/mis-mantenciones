require 'rails_helper'
require 'contexts/search_patent.rb'
require 'capybara/rspec'

describe "Search Patent", :type => :feature do

  context 'With found Patent' do

    before(:each) do
      create_search_patent_context
    end

    context 'With no kms input' do

      it 'render results page with vehicle\'s data' do
        create_search_patent_stub_proc.call(toyota_land_cruiser_finder_attributes)
        visit '/'
        click_button 'Busca Servicios'
        click_link 'Mi Pauta'
        within '.search-patent' do
          fill_in 'search_patent', with: 'AAA000'
          click_button 'Consultar'
        end

        expect(page.find(:xpath,".//section[@id='section-guideline']/div/div/div/ul/li/div/h2").text).to eq('Mantenciones para tu TOYOTA LANDCRUISER 2015')

        expect(page).to have_xpath(".//span[@class='lead']")
        expect(page.find(:xpath,".//span[@class='lead']").text).to eq('Mantención 10.000 kms')
      end
    end

    context 'With kms input' do

      it 'render results page with vehicle\'s data' do
        create_search_patent_stub_proc.call(toyota_land_cruiser_finder_attributes)
        visit '/'
        click_button 'Busca Servicios'
        click_link 'Mi Pauta'
        within '.search-patent' do
          fill_in 'search_patent', with: 'AAA000'
          fill_in 'search_kms', with: '18000' # The closest pauta is 20.000
          click_button 'Consultar'
        end

        expect(page.find(:xpath,".//section[@id='section-guideline']/div/div/div/ul/li/div/h2").text).to eq('Mantenciones para tu TOYOTA LANDCRUISER 2015')

        expect(page).to have_xpath(".//span[@class='lead']")
        expect(page.find(:xpath,".//span[@class='lead']").text).to eq('Mantención 20.000 kms')
      end
    end
  end

  context 'With not found Patent' do

    before(:each) do
      create_search_patent_context
    end

    it 'render results page with general vehicle\'s data' do
      create_search_patent_stub_proc.call([])
      visit '/'
      click_button 'Busca Servicios'
      click_link 'Mi Pauta'
      within '.search-patent' do
        fill_in 'search_patent', with: 'XAA000' # Patent not found in database
        click_button 'Consultar'
      end

      expect(page.find(:xpath,".//section[@id='section-guideline']/div/div/div/ul/li/div/h2").text).to eq('Mantenciones para tu AUTO O MOTO')

      expect(page).to have_xpath(".//span[@class='lead']")
      expect(page.find(:xpath,".//span[@class='lead']").text).to eq('Mantención 10.000 kms')
    end
  end
end