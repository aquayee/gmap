class AddCityCountryAddress < ActiveRecord::Migration
  def self.up
    change_table :addresses do |t|
      t.string :country
      t.string :city
    end
  end

  def self.down
  end
end
