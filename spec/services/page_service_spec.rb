require 'rails_helper'

describe PageService do

  before(:all) do
    page = create(:page, name: 'page1')
    sub_page = create(:page, name: 'page2', root_id: page.id)
    @sub_sub_page = create(:page, name: 'page3', root_id: sub_page.id)
    @page_names = [ page.name, sub_page.name, @sub_sub_page.name]
  end

  describe '#find' do

    context 'when page url is valid' do

      it 'returns page object' do
        page_service = PageService.new(@page_names)
        page = page_service.find

        expect(page).to eq(@sub_sub_page)
      end
    end

    context 'when page url contains wrong page name' do

      after do
        @page_names.shift
      end

      it 'returns PageNotFound' do
        @page_names.unshift('fakename')
        page_service = PageService.new(@page_names)
        expect{page_service.find}.to raise_error(PageService::PageNotFound)
      end
    end

    context 'when page url contains extra page names' do

      after do
        @page_names.pop
        @page_names.pop
      end

      it 'returns PageNotFound' do
        @page_names << 'fakename'
        @page_names << 'fakename1'
        page_service = PageService.new(@page_names)
        expect{page_service.find}.to raise_error(PageService::PageNotFound)
      end
    end
  end
end