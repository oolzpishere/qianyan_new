class CreateSignUpForms < ActiveRecord::Migration[6.1]
  def change
    create_table :sign_up_forms do |t|
      t.belongs_to :conference, index: true, foreign_key: true
      t.string :form_identify
      t.string :form_name
      t.string :form_type
      t.string :all_use_data_type

      t.timestamps
    end
  end
end
