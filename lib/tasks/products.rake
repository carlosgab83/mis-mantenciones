# encoding: utf-8

namespace "products" do
  namespace "cache" do

    desc "Robot that mantain cached product's prices"
    task warm: :environment do
      puts "#{Time.now}: Begin Cache Warming"
      Product.actives.not_deleted.each do |product|
        puts "Warm product: #{product.id}, name: #{product.name}"
        product.branches_products.each do |branch_product|
          puts "  Warm branch_product: #{branch_product.id}, name: #{branch_product.url}"
          branch_product.price
      end
      end
      puts "#{Time.now}: End Cache Warming"

    end
  end
end

