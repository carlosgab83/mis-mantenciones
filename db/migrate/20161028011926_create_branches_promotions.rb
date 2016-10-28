class CreateBranchesPromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :branches_promotions do |t|
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :branches_promotions, :branch,    foreign_key: true
    add_reference :branches_promotions, :promotion, foreign_key: true
  end
end
