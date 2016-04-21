# TODO los comandos podrían cargarse al levantar el archivo y no a mano

class Init

  def self.start
    Symbol.send(:define_method, :call) do
      |*args|
      true
    end
  end

end