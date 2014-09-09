module ApplicationHelper
  def preview_text(file)
    return "" unless file
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true) 
    text = Yomu.new(file).text
    return "" unless text
    text = text.strip.gsub("\n*", "<br/>").truncate(500, separator: ' ')
    content_tag("div", text.html_safe, class: 'document-preview')
  end
end
