module CotoSolutions
  class << self
    def included base #:nodoc:
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def acts_as_cached
      before_save :delete_cached
      after_destroy :delete_cached
      
      class << self        
        define_method "all_cached" do
          Rails.cache.fetch(self.name) { all }
        end
        
        define_method "delete_cached" do 
          Rails.cache.delete(self.name)
        end
        
        define_method "detect_from_cached" do |id|
          all_cached.detect{ |m| m['id'] == id }.descr rescue nil
        end
      end 

      define_method "delete_cached" do 
        Rails.cache.delete(self.class.name) if Rails.cache.read(self.class.name)
      end      
    end
  end  
end

# Set it all up.
if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, CotoSolutions)
end

if Object.const_defined?("ActionController")
  ActionController::Base.send(:helper, CotoHelper)
end

ActionView::Helpers::AssetTagHelper.register_javascript_expansion(:coto_solutions => ["path_prefix"])