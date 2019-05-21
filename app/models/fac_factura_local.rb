class FacFacturaLocal < ApplicationRecord
    validates :id_cuarto, :fecha, presence: true
    has_one :fac_factura_global
    has_many :fac_prendas
end
