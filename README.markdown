ExampleSet
==========

It's a Ruby thing, yes?

    describe "String#reverse" do
      it "should reverse strings consistently" do
        @example_set = ExampleSet.new
        @example_set.inputs = "foo", "bar", "baz"
        @example_set.outputs = "oof", "rab", "zab"
        @example_set.compare do |input, expected|
          expected.should == input.reverse
        end        
      end
    end

More in the spec.
    
Licence
-------

The One True Licence: BSD.

