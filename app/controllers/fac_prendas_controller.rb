class FacPrendasController < ApplicationController
    
    # GET: /fac_prendas
    def index
        @prendas = FacPrenda.all
        render json: @prendas, include: []
    end

    # POST: /fac_prendas
    def create
        # Generar Factura local
    end
    
end
