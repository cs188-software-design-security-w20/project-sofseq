class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.int :age
      t.int :zipcode
      t.string :phone
      t.string :country
      t.string :type
      t.string :goals

      t.timestamps
    end
  end
end
