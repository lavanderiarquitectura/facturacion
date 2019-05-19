class CreateFacRecargoOperacions < ActiveRecord::Migration[5.2]
  def change
    create_table :fac_recargo_operacions do |t|
      t.integer :recargo, null:false
      t.integer :id_operacion, null:false

      t.timestamps
    end
  end
end
