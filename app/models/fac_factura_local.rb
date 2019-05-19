class FacFacturaLocal < ApplicationRecord
    validates :fac_globals_id, uniqueness: true
    validates :id_cuarto, :fecha, presence: true
    has_one :fac_factura_global
    has_many :fac_prendas
end
