class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :number
      t.references :company, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
