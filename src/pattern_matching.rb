module ComposablePattern
	def and(*other_patterns)
		pattern = AndPattern.new
		pattern.patterns = other_patterns
		pattern.patterns << self
		pattern
	end

	def or(*other_patterns)
		pattern = OrPattern.new
		pattern.patterns = other_patterns
		pattern.patterns << self
		pattern
	end

	def not
		pattern = NotPattern.new
		pattern.pattern = self
		pattern
	end
end

class MatchException < RuntimeError
	attr_accessor :answer

	def initialize(answer=nil)
		self.answer = answer
	end
end

class Symbol
	include ComposablePattern

	def call(a_value, &context_block)
		if context_block != nil
			context_block.call.define_variable self, a_value
		end
		true
	end
end


class ValuePattern
	include ComposablePattern
	attr_accessor :value

	def call(a_value)
		self.value === a_value
	end
end

def val(a_value)
	pattern = ValuePattern.new
	pattern.value = a_value
	pattern
end


class TypePattern
	include ComposablePattern
	attr_accessor :type

	def call(a_value)
		understood_messages = a_value.class.instance_methods
		type.instance_methods.all? do |method|
			understood_messages.include? method
		end
	end
end

def type(a_type)
	pattern = TypePattern.new
	pattern.type = a_type
	pattern
end

class ListPattern
	include ComposablePattern
	attr_accessor :list, :match_size

	def call(a_list, &block)
		if type(Array).call(a_list) || !(self.list.length > a_list.length)
			same_size = true
			if match_size
				same_size = self.list.length == a_list.length
			end
			same_size & self.list.zip(a_list).all? do |pattern, value|
				pattern.call(value) do block.call end
			end
		else
			false
		end
	end
end

def is_pattern(pattern)
	duck(:call).call(pattern)
end

def list(a_list, match_size=true)
	list_pattern = []
	a_list.each do |member|
		if is_pattern member
			list_pattern << member
		else
			list_pattern << val(member)
		end
	end
	pattern = ListPattern.new
	pattern.list = list_pattern
	pattern.match_size = match_size
	pattern
end


class DuckPattern
	include ComposablePattern
	attr_accessor :duck_methods

	def call(obj)
		self.duck_methods.all? do |method|
			obj.methods.include? method
		end
	end
end

def duck(*duck_methods)
	pattern = DuckPattern.new
	pattern.duck_methods = duck_methods
	pattern
end


class Comp_pattern
	include ComposablePattern
	attr_accessor :patterns, :list_method

	def call(a_value, &block)
		patterns.send(self.list_method) do |pattern|
			pattern.call(a_value) do block.call end
		end
	end
end

class AndPattern < Comp_pattern
	def initialize
		self.list_method = :all?
	end
end

class OrPattern < Comp_pattern
	def initialize
		self.list_method = :any?
	end
end

class NotPattern
	include ComposablePattern
	attr_accessor :pattern

	def call(a_value, &block)
		!pattern.call(a_value) &block
	end
end

class PatternContext
	attr_accessor :pattern_argument

	def define_variable(sym, a_value)
		self.define_singleton_method(sym) do
			a_value
		end
	end
end

def with(*patterns, &block)
	value = pattern_argument
	all = patterns.all? do |pattern|
		pattern.call value do self end
	end
	if all
		raise MatchException.new(self.instance_eval &block)
	end
end

def otherwise(&block)
	block.call
	raise MatchException.new(nil)
end

def matches?(a_value, &block)
	begin
		context = PatternContext.new
		context.pattern_argument = a_value
		context.instance_eval &block
	rescue MatchException => e
		e.answer
	end
end

p (matches?([1, 2, 3]) do
 with(list([:a, val(2), duck(:+).and(:x)])) { a + x }
 with(list([1, 2, 3])) { 'acá no llego' }
 otherwise { 'acá no llego' }
end)
