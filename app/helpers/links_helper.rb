module LinksHelper
  def full_short_url(link)
    "#{root_url}#{link.shortcode}"
  end
end
