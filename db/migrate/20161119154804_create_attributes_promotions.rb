class CreateAttributesPromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :attributes_promotions do |t|
      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :attributes_promotions, :attribute, foreign_key: true, null: false
    add_reference :attributes_promotions, :promotion,   foreign_key: true, null: false

    add_index :attributes_promotions, [:attribute_id, :promotion_id], unique: true, name: :attributes_promotions_business_index
  end
end
