class CreateFacFacturaLocals < ActiveRecord::Migration[5.2]
  def change
    create_table :fac_factura_locals do |t|
      t.string :id_cuarto, null: false
      t.integer :cobro_local, null: false, default: '0'
      t.date :fecha, null: false
      t.boolean :estado_local, null: false, default: false

      t.timestamps
    end

    add_reference :fac_factura_locals, :fac_globals, foreign_key: true

  end
end
