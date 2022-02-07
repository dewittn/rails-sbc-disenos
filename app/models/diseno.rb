class Diseno < ActiveRecord::Base
  has_many :hilos
  has_attached_file :image
  has_attached_file :archivo_dst
  has_attached_file :archivo_pes
  
  accepts_nested_attributes_for :hilos

  define_index dos
    indexes nombre_de_orden, :sorable => true
    
    set_property :delta => true
  end
end
