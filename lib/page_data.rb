# frozen_string_literal: false

class PageData
  attr_reader :path, :views

  def initialize(path)
    @path = path
  end

  def add_view(ip)
    @views ||= []
    @views << ip
  end

  def unique_views
    @views.uniq.count
  end

  def total_views
    @views.count
  end
end
