class UrlParserService

  attr_reader :page_name, :page_names

  def initialize(params = {})
    @page_name = params.fetch(:page_name, {})
  end

  def parse
    @page_names = []
    @page_name.split('/').each do |page|
      @page_names << page
    end

  end

end