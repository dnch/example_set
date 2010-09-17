require 'example_set'

describe "An ExampleSet" do
  before(:each) do
    @example_set = ExampleSet.new
  end

  context "when it has many inputs and an equal number of expected outputs" do
    it "should offer some flexibility in the way that the user adds inputs and outputs" do
      @example_set.inputs = [:a, :b, :c]
      @example_set.inputs.should == [:a, :b, :c]
      
      @example_set.outputs = :a, :b, :c
      @example_set.outputs.should == [:a, :b, :c]
      
      @example_set.outputs = :a
      @example_set.outputs.should == [:a]
    end
    
    it "should allow users to define their and outputs using a hash" do      
      examples = { :a => :x, :b => :y, :c => :z }

      @example_set = ExampleSet.new(examples)
      @example_set.compare do |input, expected_output|
        expected_output.should == examples[input]
      end
    end

    it "should iterate over each input / expected output as a set of pairs in matched sequence" do
      inputs  = [:a, :b, :c]
      outputs = [:x, :y, :z]
      
      @example_set.inputs  = inputs
      @example_set.outputs = outputs

      current_index = 0

      @example_set.compare do |input, expected_output|
        input.should == inputs[current_index]
        expected_output.should == outputs[current_index]
        
        current_index = current_index + 1
      end
    end
    
    it "should allow comparisons to nil" do
      @example_set.inputs = nil
      @example_set.outputs = nil
      
      @example_set.compare do |input, expected_output|
        input.should == nil
        expected_output.should == nil
      end
    end
  end
  
  context "when it has many inputs and a single expected output" do
    it "should iterate over each input and compare it to the single expected output" do
      inputs = [:a, :b, :c]
      output = :z
      
      @example_set.inputs  = inputs
      @example_set.outputs = output

      current_index = 0

      @example_set.compare do |input, expected_output|
        input.should == inputs[current_index]
        expected_output.should == output
        
        current_index = current_index + 1
      end

    end
  end
  
  context "when it has many inputs and a many-but-mismatched number of expected outputs" do
    it "should raise an exception" do
      @example_set.inputs  = [:a, :b, :c]
      @example_set.outputs = [:x, :y]

      lambda { @example_set.compare { |input, output| true } }.should raise_error(ArgumentError)
    end
  end
  
  context "when it has more expected outputs than inputs" do
    it "should raise an exception" do
      @example_set.inputs  = [:a, :b, :c]
      @example_set.outputs = [:x, :y, :z, :fink]

      lambda { @example_set.compare { |input, output| true } }.should raise_error(ArgumentError)
    end
  end
  
  context "when it has either 0 inputs or outputs" do
    it "should raise an exception" do
      @example_set.inputs = []
      @example_set.outputs = [:x, :y, :z]
      lambda { @example_set.compare { |input, output| true } }.should raise_error(ArgumentError)

      @example_set.inputs = [:a, :b, :c]
      @example_set.outputs = []
      lambda { @example_set.compare { |input, output| true } }.should raise_error(ArgumentError)
    end
  end
  
end