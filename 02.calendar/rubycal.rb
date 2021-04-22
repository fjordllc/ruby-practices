# frozen_string_literal: true

require './rubycal_factory'
def do_rubycal
  order = RubyCalFactory.new
  puts order.run
end

do_rubycal