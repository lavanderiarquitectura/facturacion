class ChangeColumnInFacPrendas < ActiveRecord::Migration[5.2]
  def change
    change_column(:fac_prendas, :id_prenda, :string)
    drop_table :fac_recargo_telas
  end
end
