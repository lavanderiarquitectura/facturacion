class FacPrenda < ApplicationRecord
    validates :id_prenda, :id_cuarto, :cobro, :fecha, :fac_factura_locals_id, presence: true
    # validates :id_prenda, :fac_factura_locals_id, uniqueness: true
    has_one :fac_factura_local

    # ingresa nueva prenda en la tabla fac_prendas
    def self.insertfacprenda( id_fac_local, id_cuarto, id_prenda, cobro, fecha )
        sql = "INSERT into esquema_facturacion.fac_prendas ( id_prenda, id_cuarto, cobro, fecha, 
        fac_factura_locals_id, created_at, updated_at  ) 
        values (" + id_prenda.to_s  + ", " + id_cuarto.to_s + ", " + cobro.to_s + ", " + %Q{"#{fecha}"} + ", " + id_fac_local.to_s + ", " + "now(), " + "now() );"
        records_array = ActiveRecord::Base.connection.execute(sql)
    end
end
