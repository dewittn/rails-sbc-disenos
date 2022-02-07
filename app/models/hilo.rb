class Hilo < ActiveRecord::Base
  belongs_to :diseno
  belongs_to :color
  
  # validates_presence_of :color_id, :message => "faltan"
  
  def marca_id
    @marca_id
  end
  
  def marca_id=(id)
    @marca_id = (id.to_i rescue 0)
  end
end
