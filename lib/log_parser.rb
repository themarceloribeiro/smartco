# frozen_string_literal: false

require 'uri'
require 'ipaddr'
require_relative 'page_data'
require_relative 'log_line_validator'

class LogParser
  class NoValidLogLines < StandardError; end

  include LogLineValidator
  LINE_PARTS = 2

  attr_reader :file_path, :entries

  def initialize(file_path)
    raise Errno::ENOENT, "File #{file_path} does not exist" unless File.exist?(file_path)

    @entries = {}
    @file_path = file_path
  end

  def parse_line(line)
    parts = line.split(' ')
    url = parts.first
    ip = parts.last

    @entries[url] ||= PageData.new(url)
    @entries[url].add_view(ip)
  end

  def parse
    file = File.foreach(@file_path)
    file.each_entry do |line|
      valid_log_line?(line) ? parse_line(line) : next
    end

    return unless @entries.keys.empty?

    raise NoValidLogLines
  end

  def print_results(mode)
    rows = []
    rows << %w[URI Views]

    @entries.sort_by { |_url, data| data.send("#{mode}_views") }.reverse.each do |url, data|
      rows << [url, data.send("#{mode}_views")]
    end

    table = Terminal::Table.new rows: rows
    puts '+----------------------+'
    puts "| Pages by #{mode} views|"
    puts table
  end
end
