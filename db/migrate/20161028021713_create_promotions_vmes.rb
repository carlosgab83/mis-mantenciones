class CreatePromotionsVmes < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions_vmes do |t|
      t.float :vme_id

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_reference :promotions_vmes,   :promotion, foreign_key: true, null: false
    add_foreign_key :promotions_vmes, :vehiculo_modelo_especifico, column: :vme_id, primary_key: :vme_id

    add_index :promotions_vmes, [:promotion_id, :vme_id], unique: true, name: :promotions_vmes_business_index
  end
end
