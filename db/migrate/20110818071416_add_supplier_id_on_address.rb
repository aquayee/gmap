class AddSupplierIdOnAddress < ActiveRecord::Migration
  def self.up
    change_table :addresses do |t|
      t.integer :supplier_id
    end
  end

  def self.down
  end
end
