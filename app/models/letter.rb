class Letter
  attr_reader :char
  
  def self.all
    ('A'..'Z').map { |c| new(c) }
  end
  
  def self.find(param)
    all.detect { |l| l.to_param == param } || raise(ActiveRecord::RecordNotFound)
  end
  
  def initialize(char)
    @char = char
  end
  
  def to_param
    @char.downcase
  end
  
  def disenos
    Diseno.find(:all, :conditions => ["nombre_de_orden LIKE ?", @char + '%'], :order => "nombre_de_orden")
  end
end