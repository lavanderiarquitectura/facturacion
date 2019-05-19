class FacPrenda < ApplicationRecord
    validates :id_prenda, :id_cuarto, :cobro, :fecha, :fac_factura_locals_id, presence: true
    validates :id_prenda, :fac_factura_locals_id, uniqueness: true
    has_one :fac_factura_local
end
