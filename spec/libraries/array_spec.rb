require 'spec_helper'

describe Array do

  describe "#each_pair" do
    it "yeilds pairs" do
      out = ''
      [1,2,3,4].each_pair { |a1,a2| out << "*#{a1}#{a2}*" }
      out.should == "*12**34*"
    end
  end

  describe "#delete!" do
    it "accepts one argument and returns the array after delete" do
      [1,:a,3.14,"x"].delete!(1).should == [:a,3.14,"x"]
    end
    it "accepts a list of arguments and returns the array after delete" do
      [1,:a,3.14,"x"].delete!(1, "x").should == [:a,3.14]
    end
    it "modifies receiver" do
      a = [1,2,3]
      a.delete!(2,3)
      a.should == [1]
    end
  end

  describe "#without" do
    it "does not modify receiver" do
      a = [1,2,3]
      a.without(2,3).should == [1]
      a.should == [1,2,3]
    end
  end

end
