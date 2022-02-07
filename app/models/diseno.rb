class Diseno < ActiveRecord::Base
  has_many :hilos, :dependent => :destroy
  has_attached_file :image, :url => relative_root
  has_attached_file :archivo_dst, :url => relative_root
  has_attached_file :archivo_pes, :url => relative_root
  
  validates_presence_of :nombre_de_orden
  validates_presence_of :cantidad_del_colores
  
  accepts_nested_attributes_for :hilos, :allow_destroy => true

  define_index do
    indexes nombre_de_orden, :sorable => true
    
    set_property :delta => true
  end
  
  def relative_root
    @relative_root ||= "#{ActionController::Base.relative_url_root.to_s}/system/:attachment/:id/:style/:filename"
  end
end