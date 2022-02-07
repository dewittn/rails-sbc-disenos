require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Letter do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    # Letter.create!(@valid_attributes)
  end
  
  it "#all should return an array of letters when" do
    Letter.all.class.should == Array
    Letter.all.first.class.should == Letter
  end
  
  describe "#find" do
    it "should return a Letter model given a letter" do
      @letter = Letter.find("a")
      @letter.class.should == Letter
      @letter.char.should == "A"
    end
    
    it "should raise an error when an invalid char is passed" do
      lambda { Letter.find('1') }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "diseños" do
    it "should return returned a diseño  from a letter" do
      @diseno = Diseno.make(:nombre_de_orden => "Nelson")
      @letter = Letter.find('n')
      @letter.disenos == @diseno
    end
  end
end

