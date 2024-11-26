# frozen_string_literal: true

class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.string :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
