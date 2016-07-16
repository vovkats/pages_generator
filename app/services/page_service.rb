class PageService
  PageNotFound = Class.new(StandardError)

  def initialize(pages_names)
    @pages_names = pages_names
    @pages = Page.all
  end

  def find(root_id = nil)
    next_pages_name = @pages_names.shift
    page = @pages.find { |p| p.name == next_pages_name && p.root_id == root_id }

    if page.nil?
      raise PageNotFound
    elsif @pages.find { |p| p.root_id == page.id }.blank? && @pages_names.present?
      @pages_names.first
      raise PageNotFound.new(@pages_names.first)
    elsif @pages.find { |p| p.root_id == page.id }.present? && @pages_names.present?
      find(page.id)
    else
      page
    end
  end
end