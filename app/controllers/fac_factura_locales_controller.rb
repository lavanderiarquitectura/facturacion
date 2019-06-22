class FacFacturaLocalesController < ApplicationController
    
    def self.createlocal( id_cuarto, fecha )
        cobro = 0
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
    def self.create( id_cuarto, id_factura_global, cobro, fecha, estado_local )
        @local = FacFacturaLocal.new( :id_cuarto => id_cuarto, :fac_globals_id => id_factura_global, :cobro_local =>cobro, :fecha => fecha, :estado_local =>estado_local )
        if @local.save
            # updatecostoglobal( id_factura_global, cobro )
            return @local
        else
            return @local.errors
        end
    end


    # GET: /getlocales
    def index
        @local = FacFacturaLocal.all
        render json: @local, include: []
    end

    # Prueba update Costo
    # Retorna true si logro actualizar el costo global
    def self.updatecostoglobal( id, newcosto )
        @global = FacGlobalesController.updatecosto( id, newcosto )
    end


    def self.updatecosto( id, newcosto, id_cuarto )
        @local = FacFacturaLocal.where( "id" => id )
        costototal = 0
        
        # Solo deberia recorrerlo una vez, igual el return lo saca con el primero que encuentre
        @local.each do |registro|
            costototal = registro.cobro_local + newcosto 
        end

        # Actualizo con el costo actualizado
        if @local.update( :cobro_local => costototal )
            id_factura_global = getglobal( id_cuarto )
            if id_factura_global != -1
                updatecostoglobal( id_factura_global, newcosto )
            else
                puts "No se encontro factura global para actualizar"
                puts "FacFacturaLocalesController metodo updatecosto"    
            end
            
            return true
        else
            return false
        end
    end

    # Retorna la factura global activa de la factura local recivida
    # si no encuentra ninguna retorna -1
    def self.getglobal( id_cuarto )
        @global = FacGlobal.where( "id_cuarto" => id_cuarto )

        @global.each do |registro|
            if registro.estado_global == 0
                return registro.id
            end
        end

        return -1

    end

end
