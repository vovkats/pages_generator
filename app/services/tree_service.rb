class TreeService
  attr_reader :tree

  def initialize(pages)
    @pages = pages
    @tree = {}
  end

  def form_tree
    @tree[:root_objects] = []

    @pages.each do |page|
      if page.main?
        @tree[:root_objects] << page
        @tree["#{page.id}"] = [ ]
      else
        unless @tree.has_key?("#{page.root_id}")
          @tree["#{page.root_id}"] = []
        end

        @tree["#{page.root_id}"] << page
      end
    end

    @tree
  end

end