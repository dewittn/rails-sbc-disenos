require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Color do
  
  describe "nuevo_marca" do
    it "should be able to set a value" do
      @color = Color.new()
      @color.nuevo_marca = "test"
    end
  end
  
  describe "create_marca_from_text" do    
    it "should create a marca when nuevo_marca is set" do
      @color = Color.make(:nuevo_marca => "test")
      Marca.find_by_nombre("test").nombre.should == "Test"
    end
  
    it "should not create a marca when nuevo_marca is not set" do
      Marca.delete_all
      @color = Color.make()
      Marca.count.should == 0
    end
  end
end