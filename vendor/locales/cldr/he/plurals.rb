# -*- encoding : utf-8 -*-
{ :he => { :i18n => {:plural => { :keys => [:one, :two, :many, :other], :rule => lambda { |n| n == 1 ? :one : n == 2 ? :two : n != 0 ? :many : :other } } } } }
