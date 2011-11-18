class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name
      t.text :body
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
