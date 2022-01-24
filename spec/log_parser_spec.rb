# frozen_string_literal: false

require 'spec_helper'

describe LogParser do
  it 'should initialize with a file path' do
    p = LogParser.new('spec/fixtures/webserver.log')
    expect(p.file_path).to eq('spec/fixtures/webserver.log')
  end

  it 'should raise an error if the file doesnt exist' do
    expect do
      LogParser.new('spec/fixtures/webserver.logs')
    end.to raise_error(Errno::ENOENT)
  end

  it 'should raise an error if the log file has no valid lines' do
    expect do
      LogParser.new('spec/fixtures/empty.log').parse
    end.to raise_error(LogParser::NoValidLogLines)
  end

  it 'should parse a line' do
    p = LogParser.new('spec/fixtures/webserver.log')
    p.parse_line('/about 127.0.0.1')
    expect(p.entries.count).to eql(1)
    expect(p.entries['/about'].path).to eql('/about')
    expect(p.entries['/about'].views).to eql(['127.0.0.1'])
  end

  it 'should parse a file' do
    p = LogParser.new('spec/fixtures/webserver.log')
    p.parse
    expect(p.entries.keys.size).to eq(6)
  end
end
