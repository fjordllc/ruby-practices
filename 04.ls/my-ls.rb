#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
params = {}
opt.on('-a') { |v| params[:a] = v }
opt.on('-r') { |v| params[:r] = v }
opt.on('-l') { |v| params[:l] = v }
opt.parse!(ARGV)
