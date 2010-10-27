require 'spec_helper'

describe String do

  describe "#strip" do
    it "accepts an argument and strips it from both ends of reciever" do
      "**COOL**".strip("*").should == "COOL"
      "^COOL^".strip("^").should == "COOL"
    end

    it "supports more than one character" do
      "((((((((COOL))))))))))".strip("()").should == "COOL"
      "((((((((COOL))))))))))".strip("()").should == "COOL"
    end

    it "supports normal and special characters" do
      "!!@$()#^^COOLxxyyzzz".strip("!@$()#^xyz").should == "COOL"
    end

    it "has a bang version" do
      a = "!!@$()#^^COOLxxyyzzz"
      a.strip!("!@$()#^xyz")
      a.should == "COOL"
    end
  end

  describe "#normalize" do
    it "strips anyting but A-Z and 0-9, squeezes and underscores" do
      "** 10:10 (That's _IT_, I'm *OuT*)".normalize.should == "10_10_that_s_it_i_m_out"
    end

    it "has a bang version" do
      a = "** 10:10 (That's _IT_, I'm *OuT*)"
      a.normalize!
      a.should == "10_10_that_s_it_i_m_out"
    end

    it "returns empty string, but does not alter reveiver if no A-Z|0-9 exist" do
      a = "**%^^$%^#%*("
      a.normalize.should == ""
      a.normalize!.should_not be
      a.should == "**%^^$%^#%*("
    end

    it "keeps normal letters, including repeated letters" do
      "buzzz".normalize.should == "buzzz"
    end
  end

end
