# frozen_string_literal: false

require 'spec_helper'

describe PageData do
  it 'should initialize with a path' do
    p = PageData.new('/about')
    expect(p.path).to eq('/about')
  end

  context 'when handling views' do
    before do
      @p = PageData.new('/about')
    end

    it 'should add a view' do
      @p.add_view('127.0.0.1')
      expect(@p.views).to eq(['127.0.0.1'])
    end

    it 'should add multiple views to the same page' do
      @p.add_view('127.0.0.1')
      @p.add_view('127.0.0.2')
      @p.add_view('127.0.0.2')
      @p.add_view('127.0.0.3')

      expect(@p.views).to eq(
        [
          '127.0.0.1',
          '127.0.0.2',
          '127.0.0.2',
          '127.0.0.3'
        ]
      )
    end

    it 'should return the total views' do
      @p.add_view('127.0.0.1')
      @p.add_view('127.0.0.2')
      @p.add_view('127.0.0.2')
      @p.add_view('127.0.0.3')

      expect(@p.total_views).to eq(4)
    end

    it 'should return the unique views' do
      @p.add_view('127.0.0.1')
      @p.add_view('127.0.0.2')
      @p.add_view('127.0.0.2')
      @p.add_view('127.0.0.3')

      expect(@p.unique_views).to eq(3)
    end
  end
end
