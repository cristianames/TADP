require 'rspec'
require_relative 'tp1'

describe 'PatternMatching' do

  it 'super test hardcore PatternWith' do

    lista = [1,2,Object.new]
    pattern = with(list([duck(:+).and(type(Fixnum), :x),
                         :y.or(val(4)),duck(:+).not])) { x + y }

    resultado = pattern.match lista
    expect( resultado ).to eq 3

  end

end