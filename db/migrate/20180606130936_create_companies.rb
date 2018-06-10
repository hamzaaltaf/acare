class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.integer :package

      t.timestamps null: false
    end
  end
end
