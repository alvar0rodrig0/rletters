require 'test_helper'

class RLetters::Analysis::CraigZetaTest < ActiveSupport::TestCase
  setup do
    user = create(:user)

    # N.B.: If you do 10-doc datasets here, all the words are in common, and
    # there's no zeta scores.
    @dataset_1 = create(:full_dataset, num_docs: 2, user: user, name: 'First Dataset')
    @dataset_2 = create(:full_dataset, num_docs: 2, user: user, name: 'Second Dataset')
  end

  test 'zeta_scores are properly valued and sorted' do
    analyzer = RLetters::Analysis::CraigZeta.call(
      dataset_1: @dataset_1,
      dataset_2: @dataset_2)

    assert analyzer.zeta_scores.first[1] > analyzer.zeta_scores.reverse_each.first[1]

    analyzer.zeta_scores.values.each do |score|
      assert_includes (0..2), score
    end
  end

  test 'dataset markers work' do
    analyzer = RLetters::Analysis::CraigZeta.call(
      dataset_1: @dataset_1,
      dataset_2: @dataset_2)

    assert_equal analyzer.zeta_scores.first[0], analyzer.dataset_1_markers.first
    assert_equal analyzer.zeta_scores.reverse_each.first[0], analyzer.dataset_2_markers.first
    assert_equal analyzer.dataset_1_markers.size, analyzer.dataset_2_markers.size
  end

  test 'graph_points work' do
    analyzer = RLetters::Analysis::CraigZeta.call(
      dataset_1: @dataset_1,
      dataset_2: @dataset_2)

    assert_kind_of Float, analyzer.graph_points[0].x
    assert_kind_of Float, analyzer.graph_points[0].y
    assert_kind_of String, analyzer.graph_points[0].name

    analyzer.graph_points.each do |p|
      assert_includes (0..1), p.x
      assert_includes (0..1), p.y
      assert_includes p.name, ' Dataset: '
    end
  end

  test 'progress reporting works' do
    called_sub_100 = false
    called_100 = false

    analyzer = RLetters::Analysis::CraigZeta.call(
      dataset_1: @dataset_1,
      dataset_2: @dataset_2,
      progress: lambda do |p|
        if p < 100
          called_sub_100 = true
        else
          called_100 = true
        end
      end)

    assert called_sub_100
    assert called_100
  end
end
