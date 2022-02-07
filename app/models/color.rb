class Color < ActiveRecord::Base
  acts_as_cached
  
  belongs_to :marca
  has_many :disenos, :dependent => :delete
  attr_accessor :nuevo_marca
  
  before_save :create_marca_from_text
  
  def create_marca_from_text
    create_marca(:nombre => nuevo_marca.titlecase) unless nuevo_marca.blank?
  end
end
