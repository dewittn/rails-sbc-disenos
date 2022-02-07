class Diseno < ActiveRecord::Base
  has_many :hilos, :dependent => :destroy
  has_attached_file :image, 
                    :url => "#{ActionController::Base.relative_url_root.to_s}/system/:attachment/:id/:style/:basename.:extension", 
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension", 
                    :styles => { :medium => "300x300", :small => "100x100" }
  has_attached_file :original, 
                    :url => "#{ActionController::Base.relative_url_root.to_s}/system/:attachment/:id/:style/:basename.:extension", 
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension", 
                    :styles => { :medium => "300x300" }
  has_attached_file :archivo_dst, 
                    :url => "#{ActionController::Base.relative_url_root.to_s}/system/:attachment/:id/:style/:basename.:extension", 
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
  has_attached_file :archivo_pes, 
                    :url => "#{ActionController::Base.relative_url_root.to_s}/system/:attachment/:id/:style/:basename.:extension", 
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
  has_attached_file :names, 
                    :url => "#{ActionController::Base.relative_url_root.to_s}/system/:attachment/:id/:style/:basename.:extension", 
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"
  fires I18n.translate('design.timeline.new'), :on => :create
  fires I18n.translate('design.timeline.edit'), :on => :update
  
  validates_presence_of :nombre_de_orden
  
  accepts_nested_attributes_for :hilos, :allow_destroy => true
  
#  define_index do
#    indexes nombre_de_orden, :sorable => true
#    
#    set_property :delta => true
#  end
end