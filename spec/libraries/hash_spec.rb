require 'spec_helper'

describe Hash do

  let(:names) { {:first => 'Homer', :mi => '', :last => 'Simpson', "A" => true} }
  let(:numbers) { {:b => "0", "c" => 1} }

  describe "#parent_to?" do
    it "returns true for existing slices" do
      names.should be_parent_to(:first => "Homer", :last => "Simpson")
      names.should be_parent_to(:first => "Homer")
    end
    it "returns false for non existing slices" do
      names.should_not be_parent_to(:first => "Bart", :last => "Simpson")
      names.should_not be_parent_to(:first => "Bart")
    end
    it "supports key, value pairs" do
      names.should be_parent_to(:first, "Homer")
      names.should be_parent_to(:first, "Homer", :last, "Simpson")
      names.should_not be_parent_to(:first, "Bart")
      names.should_not be_parent_to(:first, "Bart", :last, "Simpson")
    end
    it "considers string integers with the key, value pairs call" do
      numbers.should be_parent_to(:b, 0)
      numbers.should_not be_parent_to(:b => 0)
      numbers.should be_parent_to("c", "1")
      numbers.should_not be_parent_to("c" => "1")
      numbers.should be_parent_to(:b, 0, "c", "1")
    end
  end

  describe "#all_keys?" do
    it "returns true when all keys are there" do
      names.all_keys?(:first, :last).should be
    end
    it "returns false if one keys is not there" do
      names.all_keys?(:first, :title).should_not be
    end
    it "returns false if all keys are not there" do
      names.all_keys?(:title, :other).should_not be
    end
  end

  describe "#any_key?" do
    it "returns true when any keys is there" do
      names.any_key?(:first, :title).should be
    end
    it "returns true if all keys are there" do
      names.any_key?(:first, :last).should be
    end
    it "returns false if all keys are not there" do
      names.any_key?(:title, :other).should_not be
    end
  end

  describe "#any_values?" do
    it 'returns true if one key has a value' do
      names.any_value?(:first, :others).should be
    end
    it "returns false if all keys don't exist or don't have values" do
      names.any_value?(:others, :mi).should_not be
    end
  end

  describe "#all_values?" do
    it 'returns true if all key have values' do
      names.all_values?(:first, :last).should be
    end
    it "returns false if one keys doesn't exist or doesn't have value" do
      names.all_values?(:others, :mi).should_not be
      names.all_values?(:others, :last).should_not be
      names.all_values?(:mi, :last).should_not be
    end
  end

  describe "#recursive_symbolize_keys!" do
    let(:hash) {
      {"name" => "names", "value" => names, "value_in_array" => [names] }
    }
    before do
      hash.recursive_symbolize_keys!
    end

    it 'symobolizes keys' do
      hash.keys.should =~ [:name, :value, :value_in_array]
    end

    it 'symbolizes keys in sub hashes' do
      hash[:value].keys.should =~ [:first, :mi, :last, :A]
    end

    it 'symbolizes keys in hashes inside sub arrays' do
      hash[:value_in_array].first.keys.should =~ [:first, :mi, :last, :A]
    end
  end

  describe "#nested_lookup" do
    let(:hash) { {:a => {:b => {:c => 3}}}}
    it "returns nil for non existing keys" do
      hash.nested_lookup(:X).should be_nil
    end
    it "returns nil for non existing nested keys" do
      hash.nested_lookup(:X, 1, "F").should be_nil
    end
    it "returns nil for non existing keys after valid keys" do
      hash.nested_lookup(:a,:b,:X).should be_nil
      hash.nested_lookup(:a,:X,:Y).should be_nil
    end
    it "returns hash value for partial lookup" do
      hash.nested_lookup(:a, :b).should == {:c => 3}
    end
    it "returns value for valid lookup" do
      hash.nested_lookup(:a,:b,:c).should == 3
    end
    it "returns nil for lookups that goes beyond valid ones" do
      hash.nested_lookup(:a,:b,:c,:d).should be_nil
    end
  end

  describe "#rename_keys" do
    let(:source_hash) { {:a => "Symbol", 1 => "Integer", -1 => 100, "a" => "Text"} }
    let(:renamed_hash) { source_hash.rename_keys(:a => :b, 1 => 2, -1 => -2, "a" => "b") }

    it "renames symbol key" do
      renamed_hash[:b].should == "Symbol"
    end
    it "renames integer key" do
      renamed_hash[2].should == "Integer"
    end
    it "renames text key" do
      renamed_hash["b"].should == "Text"
    end
    it "doesn't care about value type" do
      renamed_hash[-2].should == 100
    end
    it "does not modify the source hash" do
      source_hash[:a].should == "Symbol"
      source_hash[:b].should_not be
    end
    it "supports a bang version" do
      source_hash.rename_keys! :a => :b, 1 => 2, -1 => -2, "a" => "b"
      source_hash.should == {:b => "Symbol", 2 => "Integer", -2 => 100, "b" => "Text"}
    end
  end

end
