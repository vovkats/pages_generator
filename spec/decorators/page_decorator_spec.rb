require 'rails_helper'

describe PageDecorator do

  let(:page) { create(:page)}

  describe '#processed_content' do

    context 'when page content has symbols **[string]**' do

      it 'replaces symbols on <b> tag' do
        page.content = 'another text **[string]**'
        page.save

        expect(page.decorate.processed_content).to eq('another text <b>string</b>')
      end
    end

    context 'when page content has symbols \\[string]\\' do

      it 'replaces symbols on <i> tag' do
        page.content = 'another text \\[string]\\'
        page.save

        expect(page.decorate.processed_content).to eq('another text <i>string</i>')
      end
    end

    context 'when page content has symbols ((name1/name2/name3 [string]))' do

      it 'replaces symbols on link' do
        page.content = 'another text ((name1/name2/name3 [string]))'
        page.save

        expect(page.decorate.processed_content).to eq('another text <a href="/name1/name2/name3">string</a>')
      end
    end
  end
end