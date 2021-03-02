class CreateSignUpStreamCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :stream_codes do |t|
      t.belongs_to :sign_up_data, index: true, foreign_key: true
      t.belongs_to :sign_up_form, index: true, foreign_key: true
      t.belongs_to :conference, index: true, foreign_key: true

      t.string :code
      t.boolean :visible
      t.integer :position

      t.timestamps
    end
  end
end
