require 'image_processing'

module ApplicationHelper
  def markdown(text)
    Markdown.new(text).to_html
  end
end
