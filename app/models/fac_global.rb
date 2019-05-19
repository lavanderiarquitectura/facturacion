class FacGlobal < ApplicationRecord
    validates :id_cuarto, uniqueness: true
    validates :id_cuarto, :cobro_global, :fecha, :estado_global, presence: true
    
    has_many :fac_factura_locals
end
