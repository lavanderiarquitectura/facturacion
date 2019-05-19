class FacRecargoTela < ApplicationRecord
    validates :recargo, :id_tipo_tela, presence: true
end
