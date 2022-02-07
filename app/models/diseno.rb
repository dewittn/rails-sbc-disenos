class Diseno < ActiveRecord::Base
  has_many :hilos, :dependent => :destroy
  has_attached_file :image
  has_attached_file :archivo_dst
  has_attached_file :archivo_pes
  
  validates_presence_of :nombre_de_orden
  validates_presence_of :cantidad_del_colores
  
  accepts_nested_attributes_for :hilos, :allow_destroy => true

  # define_index do
  #   indexes nombre_de_orden, :sorable => true
  #   
  #   #set_property :delta => true
  # end
end