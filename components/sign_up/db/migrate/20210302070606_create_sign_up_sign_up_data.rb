class CreateSignUpSignUpData < ActiveRecord::Migration[6.1]
  def change
    create_table :sign_up_data do |t|
      t.belongs_to :sign_up_form, index: true, foreign_key: true
      t.integer :jsj_id
      t.json :entry
      t.string :use_data_type
      t.datetime :jsj_created_at
      t.datetime :jsj_updated_at
      t.string :phone
      t.string :email
      t.string :openid
      t.string :unionid

      t.timestamps
    end

    add_index :sign_up_data, :jsj_id
    add_index :sign_up_data, :phone
    add_index :sign_up_data, :email
    add_index :sign_up_data, :openid
    add_index :sign_up_data, :unionid

  end
end
