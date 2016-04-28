require 'rspec'
require_relative 'tp1'
require_relative 'age'

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
    expect(type(Symbol).call("Trust me, I'm a Symbol..")).to eq(false)
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

  it 'Combinator or se cumple si se cumple al menos uno de los matchers de la composición' do

    una_muralla = Muralla.new
    expect( (type Defensor) .or( type Atacante ).call una_muralla ).to eq true
    expect( (type Defensor) .or( type Atacante ).call 'un_delfin' ).to eq false

  end

  it 'Negar un matcher es obtener resultado contrario en un call. Genera matcher opuesto' do

    una_muralla = Muralla.new
    un_misil = Misil.new
    expect( (type Defensor) .not.call una_muralla ).to eq false
    expect( (type Defensor) .not.call un_misil ).to eq true

  end

  it 'match de un with que matchea devuelve el resultado de la ejecucion del bloque' do

    resultado = ( with (val 5) { 9999 } ).match(5)
    expect( resultado ).to eq 9999

  end

  it 'with con un matcher de valor bindea el objeto en el cuerpo' do

    matcher = with (:size) { size }

    resultado = matcher.match(5)
    expect( resultado ).to eq 5

  end

  it 'with con un matcher de lista con match de valor bindea el objeto en el cuerpo' do

    objeto = [1]
    esperado = objeto[0] + 2;
    matcher = with (list [:a]) { a + 2 }

    resultado = matcher.match(objeto)
    expect( resultado ).to eq esperado

  end

  # it 'Por patternmatching me da 3' do
  #
  #   x = [1, 2, 3]
  #
  #   resultado = matches? x do
  #     with( list( [:a, val(2), duck(:+)] ) ) { a + 2}
  #     with( list( [1, 2, 3] ) ) { 'aca no llego' }
  #     otherwise { 'aca no llego' }
  #   end
  #
  # expect (resultado) .to eq 3
  #
  # end

end