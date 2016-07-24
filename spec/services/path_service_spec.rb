require 'rails_helper'

describe PathService do

  before do
    page = create(:page, name: 'page1')
    sub_page = create(:page, name: 'page2', root_id: page.id)
    @sub_sub_page = create(:page, name: 'page3', root_id: sub_page.id)
  end

  describe '.show_path' do

    it 'returns page url' do
      expect(
        PathService.show_path(
          @sub_sub_page.id, @sub_sub_page.name, @sub_sub_page.path
        )).to eq('/page1/page2/page3')
    end
  end

  describe '.show_path' do

    it 'returns hash' do
      path = PathService.form_path(@sub_sub_page)

      expect(path).to have_key(:root_id)
      expect(path).to have_key(:page_name)
      expect(path).to have_key(:page_id)
    end
  end
end