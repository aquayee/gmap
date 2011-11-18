# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


10.times do
  cat = Category.create(:name =>  Random.lastname )
  Random.number(30).times do
    supplier = Supplier.create(:name => Random.country + " " + Random.state_full , :body => Random.paragraphs(3), :category => cat)
    puts "creating address"
    country = Random.country
    puts country
    supplier.addresses.create(:addr => Faker::Address.street_address, :lat => Random.number(30), :lng => Random.number(50) , :country => country, :city => Random.city)
    puts "end"
  end
  Random.number(5).times do 
    sub_cat = Category.create(:name => Random.firstname, :parent => cat)
    Random.number(10).times do
      sub_sub_cat = Category.create(:name => Random.firstname, :parent => sub_cat)
    end
  end
end
