# -*- encoding : utf-8 -*-
{ sl: { i18n: {plural: { keys: [:one, :two, :few, :other], rule: lambda { |n| n % 100 == 1 ? :one : n % 100 == 2 ? :two : [3, 4].include?(n % 100) ? :few : :other } } } } }
