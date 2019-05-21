class FacGlobal < ApplicationRecord
    validates :id_cuarto, :cobro_global, :fecha, presence: true
    # validates :estado_global, inclusion: { in: [true, false] }
    # validates :estado_global, exclusion: { in: [nil] }
    
    has_many :fac_factura_locals

    # actualiza el state de una factura global
    def self.updatestatemodel( state, id )
        sql = "update fac_globals set fac_globals.estado_global=" + state + " where fac_globals.id = " + id + ";"
        records_array = ActiveRecord::Base.connection.execute(sql)
    end

end
