class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :transcript
      t.integer :section_id
      t.timestamps
    end

    add_index :lessons, :section_id
  end
end
