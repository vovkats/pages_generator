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
end
