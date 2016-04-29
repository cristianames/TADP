# require './ValueApplicator'

class Applicable
  attr_accessor :applicable, :applicator

  def initialize(applicable, applicator)
    self.applicable = applicable
    self.applicator = applicator
  end

  def call(*args)
     self.applicator.applicate(self.applicable, args)
  end
end