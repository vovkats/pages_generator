class PagesController < ApplicationController
  before_action :find_page, only: [:show, :edit, :update, :destroy,
                                   :add]

  def index
    @pages = Page.all
    @root_pages = Page.root_pages
  end

  def show
    render 'pages/show'
  end

  def add
    @url = "/#{params[:page_name]}"
    @action = :post
    @page = @page.sub_pages.build if @page.id

    render 'pages/new'
  end

  def new
    @url = "/#{params[:page_name]}"
    @action = :post

    @page = Page.new
  end

  def edit
    @url = "/#{params[:page_name]}"
    @method = :patch
    render 'pages/edit'
  end

  def create
    @url = params[:page_name] ? "/#{params[:page_name]}/" : '/'
    @action = :post

    @page = Page.new(page_params)

    if @page.save
      redirect_to @url + @page.name, notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def update
    @url ="/#{params[:page_name]}"
    @method = :patch

    if @page.update(page_params)
      redirect_to @url, notice: 'Page was successfully updated.'
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
    rescue ActiveRecord::RecordNotFound => e
      flash[:notice] = "Page with name #{e} not found"
      redirect_to root_path and return
    end

    def page_params
      params.require(:page).permit(:name, :content, :root_id)
    end
end
