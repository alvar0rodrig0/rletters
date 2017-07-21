require 'test_helper'

class SearchResultPresenterTest < ActiveSupport::TestCase
  test 'num_hits_string returns "in database" without search' do
    r = flexmock(num_hits: 100, params: {})
    pres = RLetters::Presenters::SearchResultPresenter.new(result: r)

    assert_equal '100 articles in database', pres.num_hits_string
  end

  test 'num_hits_string returns "found" with search' do
    r = flexmock(num_hits: 100, params: { q: 'Test search' })
    pres = RLetters::Presenters::SearchResultPresenter.new(result: r)

    assert_equal '100 articles found', pres.num_hits_string
  end

  test 'num_hits_string returns "found" with faceting' do
    r = flexmock(num_hits: 100,
                 params: { fq: ['journal:(PLoS Neglected Tropical Diseases)'] })
    pres = RLetters::Presenters::SearchResultPresenter.new(result: r)

    assert_equal '100 articles found', pres.num_hits_string
  end

  test 'current_sort_method works' do
    r = flexmock(params: { 'sort' => 'score desc' })
    pres = RLetters::Presenters::SearchResultPresenter.new(result: r)

    assert_equal 'Sort: Relevance', pres.current_sort_method
  end

  test 'sort_methods works' do
    r = flexmock(params: { 'sort' => 'score desc' })
    pres = RLetters::Presenters::SearchResultPresenter.new(result: r)

    assert_equal 'Sort: Relevance', pres.sort_methods.assoc('score desc')[1]
    assert_equal 'Sort: Title (ascending)', pres.sort_methods.assoc('title_sort asc')[1]
    assert_equal 'Sort: Journal (descending)', pres.sort_methods.assoc('journal_sort desc')[1]
    assert_equal 'Sort: Year (ascending)', pres.sort_methods.assoc('year_sort asc')[1]
    assert_equal 'Sort: Authors (descending)', pres.sort_methods.assoc('authors_sort desc')[1]
  end
end