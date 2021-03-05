class CreateSignUpForms < ActiveRecord::Migration[6.1]
  def change
    create_table :sign_up_forms do |t|
      t.belongs_to :conference, index: true, foreign_key: true
      t.string :form_identify
      t.string :name
      t.string :full_name
      t.string :form_type
      t.string :all_use_data_type
      t.string :sign_up_link
      t.json :form_struct

      t.timestamps
    end

    add_index :sign_up_forms, :form_identify, unique: true

  end
end
