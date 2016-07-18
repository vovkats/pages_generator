require 'rails_helper'

describe Page, type: :model do

  let(:page) { FactoryGirl.build(:page) }

  subject { page }

  it { is_expected.to be_valid }

  describe 'validation' do

    context 'when page name is blank' do
      before { page.name = '' }

      it { is_expected.to be_invalid }
    end

    context 'when page name has whitespaces' do
      before { page.name = 'page name' }

      it { is_expected.to be_invalid }
    end

    context 'when page name has incorrect symbols' do
      before { page.name = 'page??!name' }

      it { is_expected.to be_invalid }
    end

    context 'when page name has duplicate names for root' do
      before do
        page.save
        name = page.name
        @page = FactoryGirl.build(:page, name: name)
      end
      it { expect(@page).to be_invalid }
    end

    context 'when page name has duplicate names for parent' do
      before do
        page.save
        page.sub_pages.create(name: 'UNIQ_NAME', content: 'test', title: 'test')

        # page with not uniq inside closest parent
        @page = page.sub_pages.build(name: 'UNIQ_NAME', content: 'test', title: 'test')
      end
      it { expect(@page).to be_invalid }
    end

    context 'when title is blank' do
      before { page.title = '' }

      it { is_expected.to be_invalid }
    end

    context 'when content is blank' do
      before { page.content = '' }

      it { is_expected.to be_invalid }
    end
  end

  describe '#main?' do
    let(:root_page)  { FactoryGirl.create(:page, root_id: nil) }
    let(:child_page) { FactoryGirl.create(:page, root_id: root_page.id)}

    context 'when page has not parent' do

      it 'returns true' do
        expect(root_page.main?).to be_truthy
      end
    end

    context 'when page has parent' do
      it 'returns false' do
        expect(child_page.main?).to be_falsey
      end
    end
  end

  describe '#parent?' do
    let(:root_page)  { FactoryGirl.create(:page, root_id: nil) }
    let(:child_page) { FactoryGirl.create(:page, root_id: root_page.id)}

    context 'when page has not parent' do

      it 'returns false' do
        expect(root_page.parent).to be_falsey
      end
    end

    context 'when page has parent' do
      it 'returns false' do
        expect(child_page.parent).to be_truthy
      end
    end
  end
end