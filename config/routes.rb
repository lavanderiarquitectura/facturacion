Rails.application.routes.draw do
  # fac_prendas
  resources :fac_prendas, expect:[:update, :destroy]
  #get "/prendas", to: "fac_prendas#index"

  # fac_globales
  # TODO: para esponer un get show
  # post "/createglobales", to: "fac_globales#create"   # para comentar
  # get "/getglobales", to: "fac_globales#index"        # para comentar
  # patch "/updatestateglobales/:id" , to: "fac_globales#updatestate" # para comentar
  # delete "/deleteglobal/:id",to:"fac_globales#destroy" # para comentar
  get "/getfacturaglobal/:id_cuarto", to: "fac_globales#getfactura" 
  patch "/payfactura/:id_cuarto", to: "fac_globales#payfactura"
  get "/gethabitacionescostfree", to: "fac_globales#getfree"  

  # fac_facturas_locales
  # post "/createlocales", to: "fac_factura_locales#createlocal"  # Para comentar
  # get "/getlocales", to: "fac_factura_locales#index" # para comentar
  # patch "/updateprueba", to: "fac_factura_locales#updatecostoglobal" # para ELIMINAR 

  # fac_prendas
  post "postfacprendas", to: "fac_prendas#createPrenda"
end
