require 'rails_helper'

describe UrlParserService do

  describe '#pages_names' do

    it 'returns array of page names' do
      params = { page_name: 'page1/page2/page3/page4'}
      service = UrlParserService.new(params)
      expect(service.pages_names).to match_array(['page1', 'page2', 'page3', 'page4'])
    end
  end
end