class UrlParserService

  attr_reader :pages_names

  def initialize(params = {})
    @pages_names = params.fetch(:page_name, {})
  end

  def pages_names
    @pages_names.split('/')
  end
end