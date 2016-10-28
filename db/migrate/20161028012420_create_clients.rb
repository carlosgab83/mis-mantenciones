class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :rut
      t.string :rvm_id, comment: 'is the *patente* on the rvm table'

      t.boolean :deleted, default: false
      t.timestamps
    end

    add_index :clients, [:email, :rvm_id, :deleted], unique: true

    add_foreign_key :clients, :rvm, column: :rvm_id, primary_key: "v_rvm"
  end
end
