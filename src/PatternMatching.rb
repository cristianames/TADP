require File.expand_path(File.dirname(__FILE__) + '/ComposablePattern.rb')
require File.expand_path(File.dirname(__FILE__) + '/../src/CompPattern')
require File.expand_path(File.dirname(__FILE__) + '/../src/AndPattern')
require File.expand_path(File.dirname(__FILE__) + '/../src/DuckPattern')
require File.expand_path(File.dirname(__FILE__) + '/../src/ListPattern')
require File.expand_path(File.dirname(__FILE__) + '/../src/MatchException')
require File.expand_path(File.dirname(__FILE__) + '/../src/NotPattern')
require File.expand_path(File.dirname(__FILE__) + '/../src/OrPattern')
require File.expand_path(File.dirname(__FILE__) + '/../src/PatternContext')
require File.expand_path(File.dirname(__FILE__) + '/../src/TypePattern')
require File.expand_path(File.dirname(__FILE__) + '/../src/ValuePattern')

class Symbol
	include ComposablePattern

	def call(a_value, &context_block)
		if context_block != nil
			context_block.call.define_variable self, a_value
		end
		true
	end
end

module PatternMatching

		def val(a_value)
			pattern = ValuePattern.new
			pattern.value = a_value
			pattern
		end

		def type(a_type)
			pattern = TypePattern.new
			pattern.type = a_type
			pattern
		end

		def is_pattern(pattern)
			duck(:call, :and, :or, :not).call(pattern)
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

		def duck(*duck_methods)
			pattern = DuckPattern.new
			pattern.duck_methods = duck_methods
			pattern
		end

		# Estoy en un PatternContext
		def with(*patterns, &block)
			# Ahora creo un PatternContext propio para el with
			contexto_with = PatternContext.new
			contexto_with.pattern_argument = pattern_argument
			all = patterns.all? do |pattern|
				pattern.call pattern_argument do contexto_with end
			end
			if all
				raise MatchException.new(contexto_with.instance_eval &block)
			end
		end

		def otherwise(&block)
			raise MatchException.new(block.call)
		end

		def matches?(a_value, &block)
			begin
				context = PatternContext.new
				context.pattern_argument = a_value
				context.instance_eval &block
				raise NoMatchError.new
			rescue MatchException => e
				e.answer
			end
		end
end