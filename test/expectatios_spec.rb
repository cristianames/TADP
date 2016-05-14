require 'rspec'
require_relative '../src/PatternMatching'
require_relative '../lib/age'

class Object
  include PatternMatching
end

describe 'PatternMatching' do

  it 'Matcher identidad siempre da true' do

    expect(:a_variable_name.call('anything')).to eq(true)

  end

  it 'Matcher de valor debe comparar por identidad' do

    expect(val(5).call(5)).to eq(true)
    expect(val(5).call('5')).to eq(false)
    expect(val(5).call(4)).to eq(false)

  end

  it 'Matcher de tipo debe comparar por tipos' do

    expect(type(Integer).call(5)).to eq(true)
    expect(type(Symbol).call("Trust me, I'm a Symbol..")).to eq(false)
    expect(type(Symbol).call(:a_symbol)).to eq(true)
    expect(type(NilClass).call(nil)).to eq(true)

  end

  it 'Matcher de listas debe comparar objetos matcheando' do

    anArray = [1,2,3,4]
    #list(values, match_size?)
    expect(list([1, 2, 3, 4], true).call(anArray)).to eq(true)
    expect(list([1, 2, 3, 4], false).call(anArray)).to eq(true)

    expect(list([1, 2, 3], true).call(anArray)).to eq(false)
    expect(list([1, 2, 3], false).call(anArray)).to eq(true)

    expect(list([2, 1, 3, 4], true).call(anArray)).to eq(false)
    expect(list([2, 1, 3, 4], false).call(anArray)).to eq(false)

    #Si no se especifica, match_size? se considera true
    expect(list([1, 2, 3]).call(anArray)).to eq(false)

    #Tambien pueden combinarse con el matcher de variables
    expect(list([:a, :b, :c, :d]).call(anArray)).to eq(true)
  end

  it 'Matcher ducktyping debe comparar objetos por sus metodos' do

    psyduck = Object.new
    def psyduck.cuack
      'psy..duck?'
    end

    def psyduck.fly
      '(headache)'
    end

    class Dragon
      def fly
        'do some flying'
      end
    end
    a_dragon = Dragon.new

    expect( duck(:cuack, :fly).call(psyduck) ).to eq true
    expect( duck(:cuack, :fly).call(a_dragon) ).to eq false
    expect( duck(:fly).call(a_dragon) ).to eq true
    expect( duck(:to_s).call(Object.new) ).to eq true
  end

  it 'Combinators and deben evaluar de modo que todos los matchers lo aprueben' do

    una_muralla = Muralla.new
    un_guerrero = Guerrero.new
    expect( ( type Defensor ) .and( type Atacante ).call una_muralla ).to eq false
    expect( ( type Defensor ) .and( type Atacante ).call un_guerrero ).to eq true
    expect( ( duck :+ ) .and( type(Fixnum), val(5) ) .call 5 ).to eq true

  end

  it 'Combinator or se cumple si se cumple al menos uno de los matchers de la composición' do

    una_muralla = Muralla.new
    expect( (type Defensor) .or( type Atacante ).call una_muralla ).to eq true
    expect( (type Defensor) .or( type Atacante ).call 'un_delfin' ).to eq false

  end

  it 'Negar un matcher es obtener resultado contrario en un call. Genera matcher opuesto' do

    una_muralla = Muralla.new
    un_misil = Misil.new
    expect( (type Defensor).call(una_muralla)).to eq true
    #expect( (type Defensor).not.call(una_muralla)).to eq false
    expect( (type Defensor).call(un_misil)).to eq false
    expect( (type Defensor).not.call(un_misil)).to eq true

  end

  # it 'match de un with que matchea devuelve el resultado de la ejecucion del bloque' do
  #
  #   resultado = ( with (val 5) { 9999 } ).match(5)
  #   expect( resultado ).to eq 9999
  #
  # end
  #
  # it 'with con un matcher de valor bindea el objeto en el cuerpo' do
  #
  #   pattern = with (:size) { size }
  #
  #   resultado = pattern.match(5)
  #   expect( resultado ).to eq 5
  #
  # end
  #
  # it 'with con un matcher de lista con match de valor bindea el objeto en el cuerpo' do
  #
  #   pattern = with (list [:a]) { a + 2 }
  #
  #   resultado = pattern.match( [1] )
  #   expect( resultado ).to eq 3
  #
  # end
  #
  # it 'test combinator hardcore 1' do
  #
  #   pattern = with(duck(:+).and(type(Fixnum), :x)) { x }
  #
  #   resultado = pattern.match 3
  #   expect( resultado ).to eq 3
  #
  # end
  #
  # it 'test combinator hardcore 2' do
  #
  #   pattern = with(:y.or(val(4))) { y }
  #
  #   resultado = pattern.match 3
  #   expect( resultado ).to eq 3
  #
  # end
  #
  # it 'test combinator hardcore 3' do
  #
  #   pattern = with(duck(:+).not) { 'aca no era nada' }
  #
  #   resultado = pattern.match Object.new
  #   expect( resultado ).to eq 'aca no era nada'
  #
  # end
  #
  # it 'super test hardcore PatternWith' do
  #
  #   lista = [1,2,Object.new]
  #   pattern = with(list([duck(:+).and(type(Fixnum), :x),
  #                        :y.or(val(4)),duck(:+).not])) { x + y }
  #
  #   resultado = pattern.match lista
  #   expect( resultado ).to eq 3
  #
  # end
  #
  # it 'otherwise ejecuta el bloque ante cualquier objeto' do
  #
  #   pattern = otherwise { 'no hace nada' }
  #
  #   resultado = pattern.match 'anything'
  #   expect(resultado).to eq 'no hace nada'
  #
  # end
  #
  # it 'with 1 interrumpe evaluacion de bloque' do
  #
  #   paso_por_with = false
  #   paso_por_otherwise = false
  #
  #   def m1
  #     yield
  #   end
  #
  #   m1 { with(:x) { paso_por_with = true; }.match :asd;
  #   otherwise { paso_por_otherwise = true; p 'otherwise' }.match :asd }
  #
  #   expect(paso_por_with).to eq true
  #   expect(paso_por_otherwise).to eq false
  #
  # end
  #
  # it 'with 2 interrumpe evaluacion de bloque' do
  #
  #   paso_por_with1 = false
  #   paso_por_with2 = false
  #   paso_por_otherwise = false
  #
  #   def m1
  #     yield
  #   end
  #
  #   m1 { with(:x.not) { paso_por_with1 = true; }.match :asd;
  #   with(:x) { paso_por_with2 = true; }.match :asd;
  #   otherwise { paso_por_otherwise = true; p 'otherwise' }.match :asd }
  #
  #   expect(paso_por_with1).to eq false
  #   expect(paso_por_with2).to eq true
  #   expect(paso_por_otherwise).to eq false
  #
  # end

  it 'Por patternmatching me da 3' do

    x = [1, 2, 3]

    resultado = matches? x do
      with( list( [:a, val(2), duck(:+)] ) ) { a + 2}
      with( list( [1, 2, 3] ) ) { 'aca no llego' }
      otherwise { 'aca no llego' }
    end

  expect(resultado) .to eq 3

  end

end