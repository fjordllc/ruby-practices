#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# オプション設定
opt = OptionParser.new
options = {}
opt.on('-a [ALL]'){|v| options['-a'] = v}
opt.on('-l [LIST_VERTICAL]'){|v| options['-l'] = v}
opt.on('-r [REVERSE]'){|v| options['-r'] = v}

# 引数リストARGVをパースして各オプションブロックを実行
opt.parse!{ARGV}
p options