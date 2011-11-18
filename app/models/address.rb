class Address < ActiveRecord::Base
  validates_presence_of :addr 
  belongs_to :supplier
end
