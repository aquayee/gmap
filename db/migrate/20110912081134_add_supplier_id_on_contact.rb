class AddSupplierIdOnContact < ActiveRecord::Migration
  def self.up
    change_table :contacts do |t|
      t.integer :supplier_id
    end
  end

  def self.down
  end
end
