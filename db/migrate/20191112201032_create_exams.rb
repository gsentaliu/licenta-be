class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.string :title
      t.string :created_by

      t.timestamps
    end
  end
end
