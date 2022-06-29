#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'pathname'
require './file_dir_info'
require './appoption'

option = AppOption.new

file_dir_info = FileDirInfo.new(option)

file_dir_info.my_print
