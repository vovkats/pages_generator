class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update, :destroy, :new]
  before_action :prepare_hash_tree, only: [:index, :show]

  def index; end

  def show; end

  def new
    @page = @page.sub_pages.build if @page.id
  end

  def edit; end

  def create
    @page = Page.new(page_params.merge(name: params[:page][:name]))

    if @page.save
      @page.update!(path: PathService.form_path(@page))

      redirect_to PathService.show_path(@page.id, @page.name, @page.path), notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to PathService.show_path(@page.id, @page.name, @page.path), notice: 'Page was successfully updated.'
    else
      render :edit
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
        page_service = PageService.new(url_parser.pages_names)
        @page = page_service.find.decorate
      else
        @page = Page.new
      end
    rescue PageService::PageNotFound => e
      flash[:notice] = "Page with name #{e} not found"
      redirect_to root_path and return
    end

    def page_params
      params.require(:page).permit(:title, :content, :root_id)
    end

    def prepare_hash_tree
      tree_service = TreeService.new(Page.all)
      tree_service.form_tree
      @root_pages = tree_service.tree
    end
end
