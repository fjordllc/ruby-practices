#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
params = {}

opt.on('-m VAL') { |v| params[:month] = v }
opt.on('-y VAL') { |v| params[:year] = v }
opt.parse!(ARGV)
