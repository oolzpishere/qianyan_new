class CreateSignUpConferences < ActiveRecord::Migration[6.1]
  def change
    create_table :conferences do |t|
      t.string :name
      t.string :full_name
      t.string :eng_name
      t.date :start_date
      t.date :finish_date

      t.timestamps
    end

    add_index :conferences, :eng_name, unique: true

  end
end
