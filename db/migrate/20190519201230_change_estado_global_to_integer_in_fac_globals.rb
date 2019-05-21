class ChangeEstadoGlobalToIntegerInFacGlobals < ActiveRecord::Migration[5.2]
  def change
    change_column :fac_globals, :estado_global, :integer, :limit => 1
    change_column :fac_factura_locals, :estado_local, :integer, :limit => 1
    add_column :fac_prendas, :estado_prenda, :integer, :limit => 1
  end
end
