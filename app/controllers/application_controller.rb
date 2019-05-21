class ApplicationController < ActionController::API
    # Se incluye para poder usar el metodo respond_to que en API
    # no se encuentra por default
    include ActionController::MimeResponds
end
