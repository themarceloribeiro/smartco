# frozen_string_literal: false

module LogLineValidator
  def valid_log_line?(line)
    parts = line.split(' ')

    parts.count == 2 && valid_uri?(parts.first) && valid_ip?(parts.last)
  rescue URI::InvalidURIError
    false
  rescue IPAddr::InvalidAddressError
    false
  end

  def valid_ip?(ip)
    return true if skip_ip_validation?

    IPAddr.new(ip).ipv4?
  end

  def valid_uri?(uri)
    return true if skip_uri_validation?

    uri[0] == '/' && URI.parse(uri)
  end

  def skip_uri_validation?
    ENV['SKIP_URI_VALIDATE'] == 'true'
  end

  def skip_ip_validation?
    ENV['SKIP_IP_VALIDATION'] == 'true'
  end
end
