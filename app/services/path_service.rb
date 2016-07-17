class PathService

  class << self

    def show_path(page_id, page_name, path)
      if path[:root_id]
        page_id = path[:root_id][:page_id]
        next_page_name = path[:root_id][:page_name]
        show_path(page_id, next_page_name, path[:root_id]) + '/' + page_name
      else
        "/#{page_name}"
      end
    end

    def form_path(page)
      if page.parent
        { page_id: page.id, page_name: page.name, root_id: form_path(page.parent)}
      else
        { page_id: page.id, page_name: page.name }
      end
    end

  end
end