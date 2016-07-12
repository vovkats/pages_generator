class PathService

  class << self

    def show_path(page_id)
      page = Page.find_by(id: page_id)

      if page && page.parent
        show_path(page.parent.id) + '/' + page.name
      else
        "/#{page.name}"
      end
    end

  end
end