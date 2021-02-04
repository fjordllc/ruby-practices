#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'
require 'io/console/size'

require './lib/filedata'
require './lib/filelist'
require './lib/show'

class Ls
  attr_reader :show

  def options_parse
    opt = OptionParser.new
    params = {}

    opt.on('-a')
    opt.on('-r')
    opt.on('-l')
    opt.parse!(ARGV, into: params)
    params
  end

  def call
    option = options_parse
    @show = Show.new(ARGV[0])

    return show.list_exist? unless Dir.exist?(ARGV[0] || '.')

    option.key?(:a) ? show.list_contain_dotfile : show.list_without_dotfile
    show.list_reverse if option.key?(:r)
    option.key?(:l) ? long_format : short_format
  end

  def short_format
    show.one_liner? ? show.short_format : show.short_format_split_into_columns
  end

  def long_format
    show.list_file_stat
    show.long_format
  end
end

puts Ls.new.call
