require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hilo do
  describe "#marca_id=" do
    it "should take a string and convert it into an int." do
      @hilo = Hilo.new()
      @hilo.marca_id = "1"
      @hilo.marca_id.should == 1
    end
    
    it "should return 0 if string is not a number." do
      @hilo = Hilo.new()
      @hilo.marca_id = "A"
      @hilo.marca_id.should == 0
    end
  end
end