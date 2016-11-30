class AddPreviewTextToPromotions < ActiveRecord::Migration[5.0]
  def change
    add_column :promotions, :preview_text, :text
  end
end
