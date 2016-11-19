# encoding: utf-8
class BranchPauta

  include BranchPautaSerializer

  attr_reader :pauta, :branch, :branches_manteinance_items, :promo_price, :full_price

  def initialize(args = {})
    self.pauta = args[:pauta]
    self.branch = args[:branch]
    load
  end

  def load
    self.branches_manteinance_items = branch.branches_manteinance_items_by_pauta(pauta)
    self
  end

  def promo_price
    @promo_price ||= branches_manteinance_items.map{|bmi| bmi.promo_price}.reduce(:+)
  end

  def full_price
    @full_price ||= branches_manteinance_items.map{|bmi| bmi.full_price}.reduce(:+)
  end

  def discount_percentage
    full_price / promo_price
  end

  private

  attr_writer :pauta, :branch, :branches_manteinance_items, :promo_price, :full_price
end
