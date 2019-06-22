class FacGlobalesController < ApplicationController
    # GET: /getglobales
    def index
        @global = FacGlobal.all
        render json: @global, include: []
    end
    
    # POST: /createglobales
    def self.create( id_cuarto, fecha )
        cobro_global = 0
        estado_global = 0

        @global = FacGlobal.new( :id_cuarto => id_cuarto, :cobro_global => cobro_global, :fecha => fecha, :estado_global => estado_global )
        if @global.save
            return @global
        else
            return @global.errors
        end

    end

    # UPDATE: /updatestateglobales/:id
    # TODO: Recibir el parametro booleano como string y ser self
    def updatestate
        newstate = "1"
        @global = FacGlobal.find( params[:id] )
        FacGlobal.updatestatemodel(newstate,@global.id.to_s )
    end

    # DELETE /deleteglobal/:id
    def destroy
        @global = FacGlobal.find( params[:id] )
        if @global.destroy
            respond_to do |format|
                format.json { render json: @global, status:200 }
            end
        else
            render json: @global.errors
        end
    end

    def self.updatecosto( id, newcosto )
        @global = FacGlobal.where( "id" => id )
        costototal = 0
        
        # Solo deberia recorrerlo una vez, igual el return lo saca con el primero que encuentre
        @global.each do |registro|
            costototal = registro.cobro_global + newcosto 
        end

        # Actualizo con el costo actualizado
        if @global.update( :cobro_global => costototal )
            return true
        else
            return false
        end
    end
    
end
