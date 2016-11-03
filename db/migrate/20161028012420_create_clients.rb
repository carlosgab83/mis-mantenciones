class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :primary_last_name
      t.string :email, null: false
      t.string :phone
      t.string :rut
      t.integer :comune_id, null: false
      t.string :rvm_id, comment: 'is the *patente* on the rvm table'

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :clients, [:email, :rvm_id], unique: true, name: :clients_business_index

    add_foreign_key :clients, :comuna, column: :comune_id, primary_key: "id_comuna", null: false
    add_foreign_key :clients, :rvm, column: :rvm_id, primary_key: "v_rvm"
  end
end
