# -*- encoding : utf-8 -*-
require 'r_letters/documents/as_csl'
require 'support/doubles/document_basic'

describe RLetters::Documents::AsCSL do
  before(:each) do
    @doc = double_document_basic
    @as_csl = described_class.new(@doc)
  end

  context 'when fetching a single document' do
    before(:each) do
      @csl = @as_csl.hash
    end

    it 'creates good CSL' do
      expect(@csl['type']).to eq('article-journal')
      expect(@csl['author'][0]['family']).to eq('One')
      expect(@csl['author'][1]['given']).to eq('B.')
      expect(@csl['title']).to eq('Test Title')
      expect(@csl['container-title']).to eq('Journal')
      expect(@csl['issued']['date-parts'][0][0]).to eq(2010)
      expect(@csl['volume']).to eq('10')
      expect(@csl['issue']).to eq('20')
      expect(@csl['page']).to eq('100-200')
    end
  end

  context 'when formatting CSL citations' do
    before(:each) do
      @style = double(style: <<eos)
<style xmlns="http://purl.org/net/xbiblio/csl"  class="in-text" version="1.0">
  <info>
    <id />
    <title />
    <updated>2009-08-10T04:49:00+09:00</updated>
  </info>
  <citation>
    <layout>
      <names variable="author">
        <name />
      </names>
    </layout>
  </citation>
  <bibliography>
    <layout>
      <names variable="author">
        <name />
      </names>
    </layout>
  </bibliography>
</style>
eos
    end

    it 'formats with a CSL style' do
      expect(@as_csl.entry(@style)).to eq('A. One, B. Two')
    end

    it 'throws an error if you provide a strange argument' do
      expect {
        @as_csl.entry(37)
      }.to raise_error(NameError)
    end
  end
end