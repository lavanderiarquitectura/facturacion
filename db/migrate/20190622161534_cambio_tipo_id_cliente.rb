class CambioTipoIdCliente < ActiveRecord::Migration[5.2]
  def change
    change_column(:fac_prendas, :id_cuarto, :integer)
    change_column(:fac_factura_locals, :id_cuarto, :integer)
    change_column(:fac_globals, :id_cuarto, :integer)
  end
end
