require 'test_helper'

class CooccurrenceTest < ActiveSupport::TestCase
  test 'raises an error for invalid scoring method' do
    assert_raises(ArgumentError) do
      RLetters::Analysis::Cooccurrence.call(scoring: :nope, dataset: create(:dataset))
    end
  end

  [:log_likelihood, :mutual_information, :t_test].each do |scoring|
    test "single word analysis with #{scoring} works" do
      called_sub_100 = false
      called_100 = false

      result = RLetters::Analysis::Cooccurrence.call(
        scoring: scoring,
        dataset: create(:full_dataset, num_docs: 2),
        num_pairs: 10,
        words: 'abstract',
        window: 50,
        progress: lambda do |p|
          if p < 100
            called_sub_100 = true
          else
            called_100 = true
          end
        end)

      assert_kind_of RLetters::Analysis::Cooccurrence::Result, result
      assert_equal scoring, result.scoring

      grams = result.cooccurrences
      assert_equal 10, grams.size

      grams.each do |g|
        assert_kind_of Numeric, g[1]
        assert g[1] > 0 if g[1].is_a?(Integer)
        assert g[1].finite? if g[1].is_a?(Float)
      end

      assert called_sub_100
      assert called_100
    end

    test "multiple word analysis with #{scoring} works" do
      result = RLetters::Analysis::Cooccurrence.call(
        scoring: scoring,
        dataset: create(:full_dataset, num_docs: 2),
        num_pairs: 10,
        words: 'abstract background',
        window: 50)

      assert_kind_of RLetters::Analysis::Cooccurrence::Result, result
      assert_equal scoring, result.scoring

      grams = result.cooccurrences
      assert_equal 1, grams.size

      grams.each do |g|
        assert_kind_of Numeric, g[1]
        assert g[1] > 0 if g[1].is_a?(Integer)
        assert g[1].finite? if g[1].is_a?(Float)
      end
    end

    test "stemmed analysis with #{scoring} works" do
      result = RLetters::Analysis::Cooccurrence.call(
        scoring: scoring,
        dataset: create(:full_dataset, num_docs: 2),
        words: 'abstract',
        window: 50,
        stemming: :stem)

      assert_kind_of RLetters::Analysis::Cooccurrence::Result, result
      assert_equal scoring, result.scoring
      assert_equal :stem, result.stemming

      g = result.cooccurrences.find { |g| g.first == 'abstract ar' }
      refute_nil g
    end

    test "lemmatized analysis with #{scoring} works" do
      old_path = ENV['NLP_TOOL_PATH']
      ENV['NLP_TOOL_PATH'] = 'stubbed'

      flexmock(RLetters::Analysis::NLP).should_receive(:lemmatize_words)
        .at_least.once
        .and_return { |array| array == ['abstract'] ? ['the'] : array }

      result = RLetters::Analysis::Cooccurrence.call(
        scoring: scoring,
        dataset: create(:full_dataset, num_docs: 2),
        num_pairs: 10,
        words: 'abstract',
        window: 50,
        stemming: :lemma)

      assert_kind_of RLetters::Analysis::Cooccurrence::Result, result
      assert_equal scoring, result.scoring
      assert_equal :lemma, result.stemming

      result.cooccurrences.each do |g|
        assert g.first.start_with?('the ')
      end

      ENV['NLP_TOOL_PATH'] = old_path
    end

    # Regression test for a bug
    test "analysis with an uppercased word works with #{scoring}" do
      result = RLetters::Analysis::Cooccurrence.call(
        scoring: scoring,
        dataset: create(:full_dataset, num_docs: 2),
        num_pairs: 10,
        words: 'ABSTRACT',
        window: 50)

      assert_includes result.cooccurrences[0][0].split, 'abstract'
    end
  end
end