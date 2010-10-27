require 'spec_helper'

describe Object do

  describe "#m" do
    it "returns receiver methods" do
      "".m.should include("downcase")
    end
    it "does not include Object methods" do
      "".m.should_not include(Object.methods)
    end
    it "retruns sorted output" do
      "".m.should == "".m.sort
    end
    it "accepts a regexp and returns only method matching it" do
      boolean_methods = "".m /\?$/
      boolean_methods.should include("all?", "one?")
      boolean_methods.should_not include("downcase")
    end
  end

end
