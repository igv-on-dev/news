class CreateNewsEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :news_entries do |t|
      t.string :type
      t.datetime :published_at
      t.string :title,          null: false
      t.string :annotation,     null: false
      t.datetime :unpublish_at

      t.timestamps
    end
  end
end
