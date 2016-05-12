class Applicable

  attr_accessor :parameters, :applicator

  def initialize(applicator, *parameters)
    self.applicator = applicator
    self.parameters = parameters
  end

  def call(arg)
    applicator.applicate(parameters, arg)
  end

end
