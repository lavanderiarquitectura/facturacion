class CreateFacPrendas < ActiveRecord::Migration[5.2]
  def change
    create_table :fac_prendas do |t|
      t.integer :id_prenda, null: false
      t.string :id_cuarto, null: false
      t.integer :cobro, null: false
      t.date :fecha, null: false

      t.timestamps
    end

    add_reference :fac_prendas, :fac_factura_locals, foreign_key: true 

  end
end
