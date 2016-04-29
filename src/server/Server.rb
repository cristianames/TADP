# TODO los comandos podrían cargarse al levantar el archivo y no a mano
require_relative 'Matcher.rb'
require_relative 'matchers/Applicable'
require_relative 'matchers/ValueApplicator'


class Init
  def self.start
      Matcher.start
  end
end