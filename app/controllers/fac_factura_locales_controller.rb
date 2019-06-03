class FacFacturaLocalesController < ApplicationController
    
    def createlocal
        id_cuarto = "c8nFJeMeBh"
        cobro = 9
        fecha = '2019-05-18'
        estado_local = 0

        @global = FacGlobal.where( "id_cuarto" => id_cuarto )
        # render json: @global, include: []

        # tiene contenido?
        count = 0
        @global.each do |registro|
            count = count + 1
            
            if registro.estado_global == 0
                # se adiciona a la factura global existente, y se sale
                create( id_cuarto, registro.id, cobro, fecha, estado_local )
                return
            end
        end

        # Si no se encontro factura global
        # se crea una nueva factura global
        @newglobal = FacGlobalesController.create( id_cuarto, fecha )
        create( id_cuarto, @newglobal.id, cobro, fecha, estado_local )
        
    end

    # Crea un factura local
    def create( id_cuarto, id_factura_global, cobro, fecha, estado_local )
        @local = FacFacturaLocal.new( :id_cuarto => id_cuarto, :fac_globals_id => id_factura_global, :cobro_local =>cobro, :fecha => fecha, :estado_local =>estado_local )
        if @local.save
            updatecostoglobal( id_factura_global, cobro )
            respond_to do |format|
                format.json {render json: @local, status:201}
              end
        else
            render json: @local.errors
        end
    end


    # GET: /getlocales
    def index
        @local = FacFacturaLocal.all
        render json: @local, include: []
    end

    # Prueba update Costo
    # Retorna true si logro actualizar el costo global
    def updatecostoglobal( id, newcosto )
        @global = FacGlobalesController.updatecosto( id, newcosto )
    end

end
