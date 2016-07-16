class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update, :destroy, :add]

  def index
    tree_service = TreeService.new(Page.all)
    tree_service.form_tree
    @root_pages = tree_service.tree
  end

  def show
    render 'pages/show'
  end

  def add
    @page = @page.sub_pages.build if @page.id

    render 'pages/new'
  end

  def new
    @page = Page.new
  end

  def edit
    render 'pages/edit'
  end

  def create
    @action = :post

    @page = Page.new(page_params)

    if @page.save
      @page.update!(path: PathService.form_path(@page))

      redirect_to PathService.show_path_v2(@page.id, @page.name, @page.path), notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def update
    # VOVKA update paths if name of page was changed
    if @page.update(page_params)
      redirect_to PathService.show_path(@page.id), notice: 'Page was successfully updated.'
    else
      render 'pages/edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_url
  end

  private

    def find_page
      if params[:page_name]
        url_parser = UrlParserService.new(params)
        url_parser.parse

        page_service = PageService.new(url_parser.page_names)
        @page = page_service.find
      else
        @page = Page.new
      end
    rescue PageService::PageNotFound => e
      flash[:notice] = "Page with name #{e} not found"
      redirect_to root_path and return
    end

    def page_params
      params.require(:page).permit(:name, :content, :root_id)
    end
end
