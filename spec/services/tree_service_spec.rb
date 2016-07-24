require 'rails_helper'

describe TreeService do

  before do
    @first_root_page = create(:page, name: 'first_root_page')
    @first_sub_page = create(:page, name: 'page1', root_id: @first_root_page.id)
    create(:page, name: 'page3', root_id: @first_sub_page.id)

    @second_root_page = create(:page, name: 'second_root_page')
    @second_sub_page = create(:page, name: 'page1', root_id: @second_root_page.id)
    create(:page, name: 'page3', root_id: @second_sub_page.id)
  end

  describe '#form_tree' do

    it 'returns number of hashes' do
      tree_service = TreeService.new(Page.all)
      tree_service.form_tree
      tree = tree_service.tree
      expect(tree).to have_key(:root_objects)
      expect(tree[:root_objects]).to match_array([@first_root_page, @second_root_page])

      expect(tree).to have_key(@first_root_page.id.to_s)
      expect(tree).to have_key(@second_root_page.id.to_s)

      expect(tree).to have_key(@first_sub_page.id.to_s)
      expect(tree).to have_key(@second_sub_page.id.to_s)
    end
  end
end