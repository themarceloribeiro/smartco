#!/usr/bin/env ruby
# frozen_string_literal: false

require 'bundler'
require 'dotenv/load'
require './lib/log_parser'

environment = ENV['environment'] || 'development'
Bundler.require(:default, environment)

file_path = ARGV[0]

if file_path.nil?
  puts "Usage: #{__FILE__} <file_path>"
else
  puts "Running for #{file_path}"
  parser = LogParser.new(file_path)
  parser.parse
  parser.print_results('total')
  parser.print_results('unique')
end
