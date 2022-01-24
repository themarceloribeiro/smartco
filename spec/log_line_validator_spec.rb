# frozen_string_literal: false

require 'spec_helper'

describe LogLineValidator do
  include LogLineValidator

  it 'return true for a valid line' do
    expect(valid_log_line?('/help_page/1 127.0.0.1')).to be true
  end

  it 'should return false for an empty line' do
    expect(valid_log_line?('')).to be false
    expect(valid_log_line?('a b c')).to be false
  end

  it 'should return false for a line with a bad uri path and we want to validate uri' do
    ENV['SKIP_URI_VALIDATE'] = nil
    expect(valid_log_line?('BROKEN 127.0.0.1')).to be false
  end

  it 'should return false for a line with bad ip and we want to validate ip address' do
    ENV['SKIP_URI_VALIDATE'] = nil
    expect(valid_log_line?('/help_page/1 BROKEN')).to be false
  end

  it 'should validate a line with a bad uri path and we want to skip uri validation' do
    ENV['SKIP_URI_VALIDATE'] = 'true'
    expect(valid_log_line?('BROKEN 127.0.0.1')).to be true
  end

  it 'should validate a line with bad ip and we want to skip validate ip address validation' do
    ENV['SKIP_IP_VALIDATION'] = 'true'
    expect(valid_log_line?('/help_page/1 BROKEN')).to be true
  end
end
