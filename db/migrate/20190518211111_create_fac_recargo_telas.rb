class CreateFacRecargoTelas < ActiveRecord::Migration[5.2]
  def change
    create_table :fac_recargo_telas do |t|
      t.integer :recargo, null:false
      t.integer :id_tipo_tela, null:false

      t.timestamps
    end
  end
end
