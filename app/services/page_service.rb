class PageService


  def initialize(pages_names)
    @pages_names = pages_names
  end

  def find(root_id = nil)
    page = Page.find_by(name: @pages_names.shift, root_id: root_id)

    if page.nil?
      raise ActiveRecord::RecordNotFound
    elsif page.sub_pages.blank? && @pages_names.present?
      @pages_names.first
      raise ActiveRecord::RecordNotFound.new(@pages_names.first)
    elsif page.sub_pages.present? && @pages_names.present?
      find(page.id)
    else
      page
    end
  end
end