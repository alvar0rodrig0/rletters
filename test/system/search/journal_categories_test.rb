# frozen_string_literal: true

require 'application_system_test_case'

class JournalCategoriesTest < ApplicationSystemTestCase
  setup do
    root = Documents::Category.create(
      name: 'Root',
      journals: ['PLoS Neglected Tropical Diseases', 'Actually a Novel']
    )
    root.children.create(name: 'PNTD',
                         journals: ['PLoS Neglected Tropical Diseases'])
    root.children.create(name: 'Novel', journals: ['Actually a Novel'])
  end

  test 'add a category' do
    visit search_path

    within('.filter-list') do
      click_link('PNTD')
    end

    assert_text(/1500 articles /i)
    assert_selector 'a.nav-link', text: /Category: PNTD/
  end

  test 'clear a category' do
    visit search_path

    within('.filter-list') do
      click_link('PNTD')
      click_link('Novel')
    end

    within('.filter-list') do
      click_link('Novel')
    end

    assert_text(/1500 articles /i)
    assert_selector 'a.nav-link', text: /Category: PNTD/
  end

  test 'clear all categories' do
    visit search_path

    within('.filter-list') do
      click_link('Novel')
    end

    within('#filters') do
      click_link('Remove All')
    end

    assert_text(/1501 articles /i)
    assert_no_selector '.filter-header', text: 'Active filters'
  end
end
