class Diseno < ActiveRecord::Base
  file_column :image
  file_column :archivo_dst
  file_column :archivo_pes
  has_many :hilos
  
  def hilo_attributes=(hilo_attributes)
    hilo_attributes.each do |attributes|
      hilos.build(attributes)
    end
  end
end
