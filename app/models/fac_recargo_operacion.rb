class FacRecargoOperacion < ApplicationRecord
    validates :recargo, :id_operacion, presence: true
end
