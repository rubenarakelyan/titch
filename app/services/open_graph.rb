class OpenGraph
  def self.fetch(uri, strict: true)
    parse(HTTParty.get(uri).body, strict: strict)
  rescue HTTParty::ResponseError, SocketError
    false
  end

  def self.parse(html, strict: true)
    doc = Nokogiri::HTML.parse(html)
    page = OpenGraph::Object.new
    doc.css("meta").each do |m|
      if m.attribute("property")&.to_s&.match(/^og:(.+)$/i)
        page.add(::Regexp.last_match(1).gsub("-", "_"), m.attribute("content").to_s)
      end
    end
    return false if page.empty?

    return false if strict && !page.valid?

    page
  end

  TYPES = {
    "activity" => %w[activity sport].freeze,
    "business" => %w[bar company cafe hotel restaurant].freeze,
    "group" => %w[cause sports_league sports_team].freeze,
    "organization" => %w[band government non_profit school university].freeze,
    "person" => %w[actor athlete author director musician politician public_figure].freeze,
    "place" => %w[city country landmark state_province].freeze,
    "product" => %w[album book drink food game movie product song tv_show].freeze,
    "website" => %w[blog website].freeze
  }.freeze

  class Object
    MANDATORY_ATTRIBUTES = %w[title type image url].freeze

    def initialize
      @attribute_count = 0
    end

    def add(attribute, value)
      singleton_class.send(:define_method, attribute) do
        value
      end
      @attribute_count += 1
      nil
    end

    def schema
      OpenGraph::TYPES.each_pair do |schema, types|
        return schema if types.include?(self.type)
      end
      nil
    end

    OpenGraph::TYPES.values.flatten.each do |type|
      define_method "#{type}?" do
        self.type == type
      end
    end

    OpenGraph::TYPES.each_key do |scheme|
      define_method "#{scheme}?" do
        self.type == scheme || OpenGraph::TYPES[scheme].include?(self.type)
      end
    end

    def empty?
      @attribute_count.zero?
    end

    def valid?
      MANDATORY_ATTRIBUTES.each { |attribute| return false unless singleton_class.send(:method_defined?, attribute) }
      true
    end
  end
end
