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

    # GET /getfacturaglobal:id_cuarto
    # Retorna el costo de la factura global y activa (estado = 0) perteneciente
    # al id del cuarto.
    def getfactura
        id_global = FacFacturaLocalesController.getglobal( params[:id_cuarto] )
        if id_global != -1
            @global = FacGlobal.where( "id" => id_global, "estado_global" => 0 )
            lista_fac_locales = getfacturaslocales( @global[0].id )

            hash_body_json = {}
            hahs_facturas_locales = {}
            array_facturas_locales =[]

            lista_fac_locales.each do |registro|
                valor, fecha = FacFacturaLocalesController.getcostolocal( registro )
                @prendas = FacPrendasController.getprendasxlocal( registro )

                hahs_facturas_locales = { :no_factura_local => registro, :costo => valor, :fecha => fecha, :prendas => @prendas }
                array_facturas_locales.push hahs_facturas_locales
            end

            hash_body_json = {  :id_cuarto => params[:id_cuarto], :total => @global[0].cobro_global, :facturas_locales => array_facturas_locales }
            txt_josn = hash_body_json.to_json

            render json: txt_josn

        else
            res0 = { :id_cuarto => params[:id_cuarto], :total => 0 }
            txt_josn = res0.to_json
            render json: txt_josn
        end
    end

    # Retona una lista de ids de facturas locales pertenecientes a id de la factura global recibida
    def getfacturaslocales( id_fac_global )
        @local = FacFacturaLocal.where( "fac_globals_id" => id_fac_global )
        lista_id = []

        @local.each do |registro|
            lista_id.push registro.id 
        end

        return lista_id

    end

    # PATCH /payfactura/:id_cuarto
    # Paga la factura global (su estado pasa a ser diferente de 0)
    def payfactura()
        @global = FacGlobal.where( "id_cuarto" => params[:id_cuarto], "estado_global" => 0 )
        validador = 0

        @global.each do |registro|
            registro.update estado_global: 1
            validador += 1
        end

        if validador > 0
            hahs_pay_mensaje = { :status => "OK", :reason => "Se actualizo el estado de la factura" }
            render json: hahs_pay_mensaje
        else
            hahs_pay_mensaje = { :status => "FAIL", :reason => "No se encontro ninguna factura pendiente para ese cuarto" }
            render json: hahs_pay_mensaje
        end
        
    end

    # GET
    # Retorna todas la habitaciones que no tienen deudas
    def getfree()
        # Consume servicio de Registros para saber cuales son las habitaciones que existen
        # habitaciones = RestClient.get '3.92.2.102:8082/api/rooms'     # ip publica
        habitaciones = RestClient.get '172.31.84.51:8082/api/rooms'       # ip privada
        body = JSON.parse(habitaciones.body)
        ids_habitaciones = []

        # Una vez que obtiene todas las habitaciones que existen busca cuales de estas no tienen deudas
        
        # Se podria hacer asi si facturacion conociera todos los cuartos de ante mano
        #@global = FacGlobal.where( "estado_global" => 1 )
        #render json: @global

        body.each do |registro|
            global = FacGlobal.where( "id_cuarto" => registro['id_cuarto'], "estado_global" => 1 )
            if ( global.length > 0 )
                ids_habitaciones.push global[0]['id_cuarto']
            else
                # verifica que facturacion conosca el cuarto
                # si no lo conoce no tiene deudas
                global = FacGlobal.where( "id_cuarto" => registro['id_cuarto'] )
                if ( global.length == 0 )
                    ids_habitaciones.push registro['id_cuarto']
                end
            end
        end

        res = { :ids_habitaciones => ids_habitaciones }

        render json: res

    end
    
end
