class FacPrendasController < ApplicationController
    
    # GET: /fac_prendas
    def index
        @prendas = FacPrenda.all
        render json: @prendas, include: []
    end

    # POST: /fac_prendas
    # recibe un json con un array de datos id_cuarto, id_prenda, id_operacion, fecha
    # Los separa por paquetes y por cada uno realiza un llamado a la función create
    def createPrenda
        input_json = params[:factura]
        id_cuarto = params[:id_cuarto]
        id_fac_local = -1
        res = []

        # Busca si hay una factura local activa para ese cuarto
        @factura_local = FacFacturaLocal.where( "id_cuarto" => id_cuarto )

        @factura_local.each do |registro|
            
            # Solo deberia encontrar una o ninnguna facturas locales activas
            if registro.estado_local == 0
                id_fac_local = registro.id
            end
        end
        
        # Recorre la parte de facturacion del json recibido
        input_json.each do |index|
            fecha = index["fecha_ingreso"]
            id_operacion = index["id_operacion"]
            id_prenda = index["id_prenda"]
            cobro = ""

            # obtiene el precio "cobro" por la operacion realizada
            @recargo = FacRecargoOperacion.where( "id_operacion" => id_operacion )
            # TODO: Reconocer si la consulta esta vacia
            @recargo.each do |registro|
                cobro = registro.recargo
            end

            # Si hay una factura local activa crea una nueva fac_prenda y la asocia
           if id_fac_local != -1
            create( id_fac_local, id_cuarto, id_prenda, cobro, fecha )
            return
           end

            # si no existen facturas locales activas crea una nueva
            @newFacLocal = FacFacturaLocalesController.createlocal( id_cuarto, fecha )
            id_fac_local = @newFacLocal.id
            res.push create( @newFacLocal.id, id_cuarto, id_prenda, cobro, fecha )

        end
        render json: res
    end
    
    # crea una nueva fac_prenda
    def create ( id_fac_local, id_cuarto, id_prenda, cobro, fecha )
        @prenda = FacPrenda.new( :id_prenda => id_prenda, :id_cuarto => id_cuarto, :cobro => cobro, :fecha => fecha, :fac_factura_locals_id => id_fac_local )
        if @prenda.save
            updatecostolocal( id_fac_local, cobro, id_cuarto )
            #respond_to do |format|
            #    format.json {render json: @prenda, status:201}
            #  end

            return @prenda
        else
            return @prenda.errors
        end
    end

    def updatecostolocal( id_fac_local, newcosto, id_cuarto )
        FacFacturaLocalesController.updatecosto( id_fac_local, newcosto, id_cuarto )
    end
    
end
