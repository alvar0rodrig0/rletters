# -*- encoding : utf-8 -*-
class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :datasets, :user_id
  end
end
