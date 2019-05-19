class CreateFacGlobals < ActiveRecord::Migration[5.2]
  def change
    create_table :fac_globals do |t|
      t.string :id_cuarto, null: false, unique: true
      t.integer :cobro_global, null: false
      t.date :fecha, null: false
      t.boolean :estado_global, null: false, default: false

      t.timestamps
    end
  end
end
