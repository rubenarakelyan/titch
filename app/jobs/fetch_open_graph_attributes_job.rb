class FetchOpenGraphAttributesJob < ApplicationJob
  queue_as :default

  def perform(link_id)
    link = Link.find(link_id)
    result = OpenGraph.fetch(link.url)

    return unless result.is_a?(OpenGraph::Object)

    link.update!(title: result.title, description: result&.description, og_image_url: result.image)
  end
end
