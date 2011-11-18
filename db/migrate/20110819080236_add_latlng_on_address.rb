class AddLatlngOnAddress < ActiveRecord::Migration
  def self.up
    change_table :addresses do |t|
      t.float :lat
      t.float :lng
    end
  end

  def self.down
  end
end
