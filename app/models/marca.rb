class Marca < ActiveRecord::Base
  acts_as_cached
  has_many :colors, :dependent => :destroy
  validates_presence_of :nombre
  accepts_nested_attributes_for :colors, :allow_destroy => true#, :reject_if => proc { |attributes| attributes['nombre'].blank? }
end
