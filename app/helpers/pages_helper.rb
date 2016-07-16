module PagesHelper
  def show_page_path(page_id, page_name, page_path)
    PathService.show_path_v2(page_id, page_name, page_path)
  end

  def edit_page_path(page_id, page_name, page_path)
    "#{show_page_path(page_id, page_name, page_path)}/edit"
  end

  def add_page_path(page_id, page_name, page_path)
    "#{show_page_path(page_id, page_name, page_path)}/add"
  end

  def form_page_path(page)
    page =
      if page.id
        page
      else
        page.parent
      end

    if page
      PathService.show_path_v2(page.id, page.name, page.path)
    else
      '/'
    end
  end
end
