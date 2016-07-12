module PagesHelper
  def page_path(id)
    PathService.show_path(id)
  end

  def edit_page_path(id)
    "#{page_path(id)}/edit"
  end

  def add_page_path(id)
    "#{page_path(id)}/add"
  end
end
