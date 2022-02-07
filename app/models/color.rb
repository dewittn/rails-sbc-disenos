class Color < ActiveRecord::Base
  belongs_to :marca
  attr_accessor :nuevo_marca
  
  before_save :create_marca_from_text
  
  def create_marca_from_text
    create_marca(:nombre => nuevo_marca.titlecase) unless nuevo_marca.blank?
  end
end
