class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    uri = URI.parse(value)

    return record.errors.add(attribute, :invalid) unless %w[http https].include?(uri.scheme)

    record.errors.add(attribute, :https_only) unless uri.scheme == "https" || options[:allow_http]
    record.errors.add(attribute, :host_not_allowed) unless options[:host].nil? || uri.host =~ options[:host]
  rescue URI::InvalidURIError
    record.errors.add(attribute, :invalid)
  end
end
