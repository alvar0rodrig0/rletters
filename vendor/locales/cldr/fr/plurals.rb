# -*- encoding : utf-8 -*-
{ fr: { i18n: {plural: { keys: [:one, :other], rule: lambda { |n| n.between?(0, 2) && n != 2 ? :one : :other } } } } }
