class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :title
      t.text :message
      t.string :to

      t.timestamps null: false
    end
  end
end
