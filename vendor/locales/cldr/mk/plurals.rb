# -*- encoding : utf-8 -*-
{ :mk => { :i18n => {:plural => { :keys => [:one, :other], :rule => lambda { |n| n % 10 == 1 && n != 11 ? :one : :other } } } } }
