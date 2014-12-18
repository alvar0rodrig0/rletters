# -*- encoding : utf-8 -*-
class DropSessionsTable < ActiveRecord::Migration
  def up
    drop_table :sessions
  end

  def down
    create_table :sessions do |t|
      t.string :session_id, null: false
      t.text :data
      t.timestamps null: true
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end
end
