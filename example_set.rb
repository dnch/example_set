class ExampleSet
  attr_reader :inputs, :outputs
  
  def initialize
    @inputs  = []
    @outputs = []
  end
  
  # Give the user some flexibility in the way they 
  def inputs=(*new_inputs)
    @inputs = [new_inputs].flatten
  end
  
  def outputs=(*new_outputs)
    @outputs = [new_outputs].flatten
  end
  
  def compare    
    raise ArgumentError unless balanced?
    
    @inputs.each_with_index do |input, index|
      yield input, expected_output_for(index)
    end
  end
  
  def expected_output_for(index)
    @outputs.length == 1 ? @outputs[0] : @outputs[index]
  end
  
  private

  def balanced?
    !@inputs.empty? && (@inputs.length == @outputs.length || @outputs.length == 1)
  end
end