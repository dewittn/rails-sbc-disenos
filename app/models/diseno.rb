class Diseno < ActiveRecord::Base
  #has_attached_file :image
  #has_attached_file :archivo_dst
  #has_attached_file :archivo_pes
  has_many :hilos
  
  def hilo_attributes=(hilo_attributes)
    hilo_attributes.each do |attributes|
      hilos.build(attributes)
    end
  end
end
